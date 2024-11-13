#!/bin/bash
# Script to create a security group for web servers

# Variables
VPC_ID="vpc-your-id"  # Replace with your VPC ID
SG_NAME="WebSG"

# Create Security Group
SG_ID=$(aws ec2 create-security-group --group-name $SG_NAME --description "Web Server Security Group" --vpc-id $VPC_ID --query 'GroupId' --output text)
echo "Created Security Group with ID: $SG_ID"

# Add inbound rules for SSH and HTTP
aws ec2 authorize-security-group-ingress --group-id $SG_ID --protocol tcp --port 22 --cidr "YOUR_PUBLIC_IP/32"  # Replace YOUR_PUBLIC_IP with your public IP
aws ec2 authorize-security-group-ingress --group-id $SG_ID --protocol tcp --port 80 --cidr 0.0.0.0/0
echo "Added inbound rules for SSH and HTTP."

# Add outbound rule
aws ec2 authorize-security-group-egress --group-id $SG_ID --protocol tcp --port 1024-65535 --cidr 0.0.0.0/0
echo "Added outbound rule for HTTP and TCP traffic."
