#!/bin/bash
# Script to create and configure route tables

# Variables
VPC_ID="vpc-your-id"  # Replace with your VPC ID
IGW_ID="igw-your-id"   # Replace with your Internet Gateway ID
RT_NAME="internetRT"

# Create Route Table
RT_ID=$(aws ec2 create-route-table --vpc-id $VPC_ID --query 'RouteTable.RouteTableId' --output text)
aws ec2 create-tags --resources $RT_ID --tags Key=Name,Value=$RT_NAME
echo "Created Route Table with ID: $RT_ID"

# Associate subnets with the route table
aws ec2 associate-route-table --subnet-id subnet-your-id-1a --route-table-id $RT_ID
aws ec2 associate-route-table --subnet-id subnet-your-id-1b --route-table-id $RT_ID
echo "Associated route table with subnets 1a and 1b."

# Create route for Internet Gateway (0.0.0.0/0)
aws ec2 create-route --route-table-id $RT_ID --destination-cidr-block 0.0.0.0/0 --gateway-id $IGW_ID
echo "Added route to route table for internet access."
