#!/bin/bash
# Script to create VPC and Subnets

# Variables
VPC_NAME="myvpc"
VPC_CIDR="10.0.0.0/16"
SUBNETS=("10.0.1.0/24" "10.0.2.0/24" "10.0.3.0/24")
ZONES=("us-east-1a" "us-east-1b" "us-east-1c")
SUBNET_NAMES=("subnet-1a" "subnet-1b" "subnet-1c")

# Create VPC
VPC_ID=$(aws ec2 create-vpc --cidr-block $VPC_CIDR --query 'Vpc.VpcId' --output text)
aws ec2 create-tags --resources $VPC_ID --tags Key=Name,Value=$VPC_NAME
echo "Created VPC with ID: $VPC_ID"