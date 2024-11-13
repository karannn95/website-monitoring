#!/bin/bash
# Script to create an Auto Scaling group

# Variables
LAUNCH_TEMPLATE_NAME="MYtemplate"  # Replace with your launch template name
LOAD_BALANCER_NAME="NVLoadBalancer"  # Replace with your load balancer name

# Create Auto Scaling Group
aws autoscaling create-auto-scaling-group --auto-scaling-group-name MYAutoscalingGroup --launch-template "LaunchTemplateName=$
