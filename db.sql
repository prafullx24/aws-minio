CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    password_hash TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW(),
    is_active BOOLEAN DEFAULT TRUE
);

CREATE TABLE subscriptions (
    id SERIAL PRIMARY KEY,
    user_id INT REFERENCES users(id) ON DELETE CASCADE,
    plan_name VARCHAR(255) NOT NULL,
    start_date TIMESTAMP DEFAULT NOW(),
    end_date TIMESTAMP,
    status VARCHAR(50) CHECK (status IN ('active', 'expired', 'canceled')),
    created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE payments (
    id SERIAL PRIMARY KEY,
    subscription_id INT REFERENCES subscriptions(id) ON DELETE CASCADE,
    amount DECIMAL(10,2) NOT NULL,
    payment_date TIMESTAMP DEFAULT NOW(),
    payment_method VARCHAR(50),
    transaction_id VARCHAR(255) UNIQUE
);

CREATE TABLE invites (
    id SERIAL PRIMARY KEY,
    inviter_id INT REFERENCES users(id) ON DELETE SET NULL,
    invite_code VARCHAR(50) UNIQUE NOT NULL,
    invitee_email VARCHAR(255) UNIQUE NOT NULL,
    accepted BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT NOW(),
    accepted_at TIMESTAMP
);

CREATE TABLE projects (
    id SERIAL PRIMARY KEY,
    user_id INT REFERENCES users(id) ON DELETE CASCADE,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    status VARCHAR(50) CHECK (status IN ('active', 'archived', 'deleted')),
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE files (
    id SERIAL PRIMARY KEY,
    project_id INT REFERENCES projects(id) ON DELETE CASCADE,
    user_id INT REFERENCES users(id) ON DELETE SET NULL,
    file_name VARCHAR(255) NOT NULL,
    file_type VARCHAR(50),
    file_size BIGINT,
    upload_date TIMESTAMP DEFAULT NOW(),
    ocr_status VARCHAR(50) CHECK (ocr_status IN ('pending', 'processing', 'completed', 'failed')),
    extracted_data JSONB,  -- Storing structured OCR results in JSON
    deleted BOOLEAN DEFAULT FALSE
);

CREATE TABLE ocr_files (
    id SERIAL PRIMARY KEY,
    file_id INT REFERENCES files(id) ON DELETE CASCADE,
    ocr_file_name VARCHAR(255) NOT NULL,
    file_type VARCHAR(50),
    s3_url TEXT NOT NULL,
    uploaded_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE flowcharts (
    id SERIAL PRIMARY KEY,
    project_id INT REFERENCES projects(id) ON DELETE CASCADE,
    file_name VARCHAR(255) NOT NULL,
    s3_url TEXT NOT NULL,
    version INT DEFAULT 1,
    latest BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT NOW()
);

-- CREATE TABLE file_relationships (
--     id SERIAL PRIMARY KEY,
--     file_id_1 INT REFERENCES files(id) ON DELETE CASCADE,
--     file_id_2 INT REFERENCES files(id) ON DELETE CASCADE,
--     relation_type VARCHAR(50),  -- e.g., "derived from", "linked to"
--     created_at TIMESTAMP DEFAULT NOW()
-- );

CREATE TABLE audit_logs (
    id SERIAL PRIMARY KEY,
    user_id INT REFERENCES users(id) ON DELETE SET NULL,
    action TEXT NOT NULL,
    entity_type VARCHAR(50),  -- "file", "project", "flowchart"
    entity_id INT NOT NULL,
    timestamp TIMESTAMP DEFAULT NOW()
);


