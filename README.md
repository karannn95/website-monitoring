# AWS Infrastructure Setup from Scratch

This project provides a step-by-step guide to setting up a complete AWS infrastructure from scratch, suitable for organizations transitioning from physical servers to a fully managed, cloud-based environment.

---

## Table of Contents
- [Project Overview](#project-overview)
- [Architecture](#architecture)
- [Prerequisites](#prerequisites)
- [Setup Guide](#setup-guide)
  - [1. VPC Configuration](#1-vpc-configuration)
  - [2. Subnet Setup](#2-subnet-setup)
  - [3. Internet Gateway & Route Tables](#3-internet-gateway--route-tables)
  - [4. NAT Gateway Setup](#4-nat-gateway-setup)
  - [5. SNS Configuration](#5-sns-configuration)
  - [6. S3 Bucket Creation](#6-s3-bucket-creation)
  - [7. IAM Role Creation](#7-iam-role-creation)
  - [8. EFS Setup](#8-efs-setup)
  - [9. Security Groups](#9-security-groups)
  - [10. Load Balancer Setup](#10-load-balancer-setup)
  - [11. Launch Template & Auto Scaling](#11-launch-template--auto-scaling)
  - [12. Jump Server Setup](#12-jump-server-setup)
  - [13. Database Server Setup](#13-database-server-setup)
  - [14. Flow Logs and Monitoring](#14-flow-logs-and-monitoring)
- [Verification & Testing](#verification--testing)
- [Troubleshooting & Maintenance](#troubleshooting--maintenance)
- [Conclusion](#conclusion)

---

## Project Overview

This AWS setup includes creating a Virtual Private Cloud (VPC) with public and private subnets, setting up NAT and Internet Gateways, configuring S3 buckets, implementing Elastic File System (EFS), creating an IAM role, Auto Scaling, Load Balancer, and Security Groups. The infrastructure is designed to support high availability, scalability, and security best practices.

---

## Architecture

The architecture includes:
- A custom VPC with public and private subnets.
- An Internet Gateway for public access and a NAT Gateway for private access.
- Security Groups and Network ACLs to control access.
- Auto-scaling EC2 instances behind a Load Balancer.
- S3 Buckets, EFS for storage, and an SNS topic for notifications.

---

## Prerequisites

- **AWS Account**: An active AWS account with administrative privileges.
- **IAM Permissions**: Sufficient permissions to create VPCs, EC2 instances, S3 buckets, and IAM roles.
- **AWS CLI**: Installed and configured with the required IAM role for CLI access.

---

## Setup Guide

### 1. VPC Configuration

1. **Login to AWS Console**: Set region to **us-east-1** (North Virginia).
2. **Create VPC**:
   - Go to **VPC** > **Your VPCs** > **Create VPC**
   - Name: `myvpc`
   - IPv4 CIDR: `10.0.0.0/16`
   - Click **Create VPC**.

### 2. Subnet Setup

Create three subnets in different Availability Zones:

1. **Public Subnet (1)**:
   - Name: `public-subnet-1`
   - IPv4 CIDR: `10.0.1.0/24`
   - AZ: `us-east-1a`

2. **Public Subnet (2)**:
   - Name: `public-subnet-2`
   - IPv4 CIDR: `10.0.2.0/24`
   - AZ: `us-east-1b`

3. **Private Subnet**:
   - Name: `private-subnet`
   - IPv4 CIDR: `10.0.3.0/24`
   - AZ: `us-east-1c`

Enable public IP assignment for the public subnets.

### 3. Internet Gateway & Route Tables

1. **Create Internet Gateway**:
   - Name: `myIGW`
   - Attach to `myvpc`.

2. **Route Table**:
   - Name: `internetRT`
   - Associate with `public-subnet-1` and `public-subnet-2`.
   - Set route for `0.0.0.0/0` to `myIGW`.

### 4. NAT Gateway Setup

1. **Create NAT Gateway**:
   - Subnet: `public-subnet-1`
   - Allocate Elastic IP.
   - Associate NAT Gateway route with `private-subnet` route table.

### 5. SNS Configuration

1. **Create SNS Topic**: Name `AWS-Team`.
2. **Create Subscription**:
   - Protocol: Email
   - Endpoint: `example@example.com`
   - Confirm subscription via email.

### 6. S3 Bucket Creation

Create three S3 buckets:

- Bucket Names: `flow-logs`, `firstbucket-example`, `secondbucket-example`
- Disable public access and enable ACLs.

### 7. IAM Role Creation

1. **Create IAM Role**:
   - Role Type: EC2
   - Attach `AmazonS3FullAccess` policy.
   - Role Name: `EC2-S3-role`.

### 8. EFS Setup

1. **Create EFS**:
   - Name: `MyEFS`
   - VPC: `myvpc`
   - Ensure DNS resolution and hostname are enabled on VPC.

### 9. Security Groups

Create security groups:

- **WebSG**: Allows SSH from `my IP`, HTTP from anywhere.
- **DBSG**: Allows MySQL access from specific IPs.

### 10. Load Balancer Setup

1. **Create Load Balancer**:
   - Type: Classic
   - Name: `NVLoadBalancer`
   - Attach to `myvpc` with `public-subnet-1` and `public-subnet-2`.
   - Associate security group: `default`.

### 11. Launch Template & Auto Scaling

1. **Create Launch Template**:
   - Name: `MYtemplate`
   - OS: Amazon Linux
   - Instance Type: `t2.micro`
   - Key Pair: `mykey1`
   - Security Group: `WebSG`
   - IAM Role: `EC2-S3-role`.

2. **Auto Scaling Group**:
   - Name: `MYAutoscalinggroup`
   - Attach Load Balancer: `NVLoadBalancer`
   - Min: 4, Max: 10
   - CPU Target: 90% utilization.

### 12. Jump Server Setup

1. **Launch Jump Server**:
   - Use `public-subnet-1` and `public-subnet-2`.
   - Security Group: `JumpSG`.

### 13. Database Server Setup

1. **Launch Database Server**:
   - Use `private-subnet`.
   - Security Group: `DBSG`.
   - Configure MySQL access from jump servers.

### 14. Flow Logs and Monitoring

1. **Enable Flow Logs**:
   - Attach to `myvpc`, save logs in `flow-logs` S3 bucket.

2. **CloudWatch Dashboard**:
   - Monitor Auto Scaling Group `MYAutoscalinggroup` CPU utilization.

---

## Verification & Testing

1. **Load Balancer**: Access public DNS to verify load balancer connectivity.
2. **EFS**: Check mounting on web servers.
3. **SNS Subscription**: Verify notifications via email.
4. **Database Server**: Connect via jump server to confirm access.
5. **S3 Bucket Access**: Mount and verify S3 bucket access from EC2 instances.

---

## Troubleshooting & Maintenance

- **Connection Issues**: Check Security Groups and NACLs for correct rules.
- **NAT Gateway**: Ensure NAT is in a public subnet with Elastic IP.
- **IAM Role Permissions**: Confirm necessary IAM policies are attached.

---
