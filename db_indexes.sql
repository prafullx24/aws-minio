-- USERS TABLE
CREATE INDEX idx_users_email ON users(email);

-- SUBSCRIPTIONS TABLE
CREATE INDEX idx_subscriptions_user_id ON subscriptions(user_id);
CREATE INDEX idx_subscriptions_status ON subscriptions(status);

-- PAYMENTS TABLE
CREATE INDEX idx_payments_subscription_id ON payments(subscription_id);
CREATE INDEX idx_payments_payment_date ON payments(payment_date);

-- INVITES TABLE
CREATE INDEX idx_invites_invite_code ON invites(invite_code);
CREATE INDEX idx_invites_inviter_id ON invites(inviter_id);
CREATE INDEX idx_invites_invitee_email ON invites(invitee_email);

-- PROJECTS TABLE
CREATE INDEX idx_projects_user_id ON projects(user_id);
CREATE INDEX idx_projects_status ON projects(status);
CREATE INDEX idx_projects_created_at ON projects(created_at);

-- FILES TABLE
CREATE INDEX idx_files_project_id ON files(project_id);
CREATE INDEX idx_files_user_id ON files(user_id);
CREATE INDEX idx_files_ocr_status ON files(ocr_status);
CREATE INDEX idx_files_upload_date ON files(upload_date);
CREATE INDEX idx_files_deleted ON files(deleted);

-- OCR_FILES TABLE
CREATE INDEX idx_ocr_files_file_id ON ocr_files(file_id);

-- FLOWCHARTS TABLE
CREATE INDEX idx_flowcharts_project_id ON flowcharts(project_id);
CREATE INDEX idx_flowcharts_latest ON flowcharts(latest);

-- FILE RELATIONSHIPS TABLE (if used)
CREATE INDEX idx_file_relationships_file1 ON file_relationships(file_id_1);
CREATE INDEX idx_file_relationships_file2 ON file_relationships(file_id_2);
CREATE INDEX idx_file_relationships_relation_type ON file_relationships(relation_type);

-- AUDIT LOGS TABLE (if used)
CREATE INDEX idx_audit_logs_user_id ON audit_logs(user_id);
CREATE INDEX idx_audit_logs_entity_type ON audit_logs(entity_type);
CREATE INDEX idx_audit_logs_entity_id ON audit_logs(entity_id);
CREATE INDEX idx_audit_logs_timestamp ON audit_logs(timestamp);

-- Composite Index
CREATE INDEX idx_files_project_ocr_status ON files(project_id, ocr_status);
CREATE INDEX idx_flowcharts_project_latest ON flowcharts(project_id, latest);

