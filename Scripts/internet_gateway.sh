#!/bin/bash
# Script to create and attach an Internet Gateway

# Variables
VPC_ID="vpc-your-id"  # Replace with your VPC ID
IGW_NAME="myIGW"

# Create Internet Gateway
IGW_ID=$(aws ec2 create-internet-gateway --query 'InternetGateway.InternetGatewayId' --output text)
aws ec2 create-tags --resources $IGW_ID --tags Key=Name,Value=$IGW_NAME
echo "Created Internet Gateway with ID: $IGW_ID"

# Attach Internet Gateway to VPC
aws ec2 attach-internet-gateway --internet-gateway-id $IGW_ID --vpc-id $VPC_ID
echo "Attached Internet Gateway to VPC $VPC_ID"
