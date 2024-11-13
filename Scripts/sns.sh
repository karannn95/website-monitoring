#!/bin/bash
# Script to create an SNS topic and subscription

# Create SNS Topic
TOPIC_NAME="AWS_Team"
TOPIC_ARN=$(aws sns create-topic --name $TOPIC_NAME --query 'TopicArn' --output text)
echo "Created SNS Topic: $TOPIC_ARN"

# Create Subscription
aws sns subscribe --topic-arn $TOPIC_ARN --protocol email --notification-endpoint "rahoolnew@gmail.com"
echo "Created subscription for email notifications."
