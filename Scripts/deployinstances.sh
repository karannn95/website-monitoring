#!/bin/bash
# Script to create Jump Server (Bastion host)

# Variables
AMI_ID="ami-xxxxxxxxxxxxxxxxx"  # Replace with an appropriate Amazon Linux 2 or Ubuntu AMI ID
INSTANCE_TYPE="t3.micro"
KEY_PAIR="your-key-pair"  # Replace with your SSH key pair name
SECURITY_GROUP_ID="sg-xxxxxxxxxx"  # Replace with your security group ID
SUBNET_ID="subnet-your-id-1a"  # Replace with your public subnet ID

# Launch EC2 instance for Jump Server
INSTANCE_ID=$(aws ec2 run-instances --image-id $AMI_ID --instance-type $INSTANCE_TYPE --key-name $KEY_PAIR --security-group-ids $SECURITY_GROUP_ID --subnet-id $SUBNET_ID --associate-public-ip-address --query 'Instances[0].InstanceId' --output text)
echo "Launched Jump Server with Instance ID: $INSTANCE_ID"

# Optionally, you can also assign Elastic IP to this Jump Server
EIP_ALLOC_ID=$(aws ec2 allocate-address --query 'AllocationId' --output text)
aws ec2 associate-address --instance-id $INSTANCE_ID --allocation-id $EIP_ALLOC_ID
echo "Elastic IP assigned to Jump Server."

# Add an SSH key for easy access to the Jump Server
aws ec2 create-key-pair --key-name "JumpServerKey" --query 'KeyMaterial' --output text > JumpServerKey.pem
chmod 400 JumpServerKey.pem
echo "SSH Key pair for Jump Server created."
