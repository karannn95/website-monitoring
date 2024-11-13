#!/bin/bash
# Script to create and configure a NAT Gateway

# Variables
VPC_ID="vpc-your-id"  # Replace with your VPC ID
SUBNET_ID="subnet-your-id-1a"  # Replace with public subnet ID
EIP_ALLOC_ID=$(aws ec2 allocate-address --query 'AllocationId' --output text)

# Create NAT Gateway
NAT_GW_ID=$(aws ec2 create-nat-gateway --subnet-id $SUBNET_ID --allocation-id $EIP_ALLOC_ID --query 'NatGateway.NatGatewayId' --output text)
echo "Created NAT Gateway with ID: $NAT_GW_ID"

# Update the route table to use the NAT Gateway
NAT_RT_ID="nat-rt-id"  # Replace with your private route table ID
aws ec2 create-route --route-table-id $NAT_RT_ID --destination-cidr-block 0.0.0.0/0 --gateway-id $NAT_GW_ID
echo "Added route to private route table using NAT Gateway."
