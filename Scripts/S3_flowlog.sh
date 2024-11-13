#!/bin/bash
# Script to create an S3 bucket

# Variables
BUCKET_NAME="my-unique-s3-bucket-name"  # Replace with a globally unique name

# Create S3 Bucket
aws s3api create-bucket --bucket $BUCKET_NAME --region us-east-1 --create-bucket-configuration LocationConstraint=us-east-1
echo "Created S3 Bucket: $BUCKET_NAME"

# Enable versioning on the bucket (optional)
aws s3api put-bucket-versioning --bucket $BUCKET_NAME --versioning-configuration Status=Enabled
echo "Enabled versioning for S3 Bucket: $BUCKET_NAME"
