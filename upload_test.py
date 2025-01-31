import boto3
from botocore.client import Config

# MinIO server details
minio_endpoint = "http://192.168.1.72:9000"  # Change to your MinIO address
access_key = "PpibfxXqfDKrXg7yq619"
secret_key = "T3xs3s3kwVdJPDMIUTqO6SJEyVl94rHpP5wBteU3"
bucket_name = "test"
file_path = "myfile.txt"
object_name = "myfile.txt"  # The name under which the file will be stored in MinIO

# Create an S3 client with MinIO details
s3_client = boto3.client(
    "s3",
    endpoint_url=minio_endpoint,  # Important: MinIO requires specifying the endpoint
    aws_access_key_id=access_key,
    aws_secret_access_key=secret_key,
    config=Config(signature_version="s3v4"),  # Use AWS Signature v4
    region_name="us-east-1"  # MinIO does not use regions, but boto3 requires one
)

# Upload the file
s3_client.upload_file(file_path, bucket_name, object_name)
print(f"File '{file_path}' uploaded to MinIO bucket '{bucket_name}' as '{object_name}'.")
