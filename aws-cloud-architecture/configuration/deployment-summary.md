# AWS Cloud Architecture - Deployment Summary

## Quick Reference

**Project:** AWS Academy Cloud Architecting Capstone Project  
**Completion Date:** May 6, 2026  
**Grade:** 35/35 (100%)  
**Deployment Time:** ~4 hours

---

## AWS Resources Deployed

### **VPC Configuration**
- **VPC Name:** Project VPC
- **Region:** us-east-1
- **Availability Zones:** us-east-1a, us-east-1b
- **Public Subnets:** 2 (one per AZ)
- **Private Subnets:** 2 (one per AZ)

### **Database (Amazon RDS)**
- **Database Identifier:** countries-db
- **Engine:** MySQL
- **Instance Class:** db.t3.micro
- **Storage:** 20 GiB
- **Deployment:** Single-AZ (Dev/Test)
- **Network:** Private subnets
- **Security Group:** ExampleDB-SG
- **Credentials:** AWS Secrets Manager
- **Database Name:** countries

### **Application Load Balancer**
- **Name:** countries-alb
- **Type:** Application Load Balancer
- **Scheme:** Internet-facing
- **Availability Zones:** us-east-1a, us-east-1b
- **Subnets:** Public Subnet 1, Public Subnet 2
- **Security Group:** ALBSG
- **Target Group:** countries-tg
- **DNS Name:** countries-alb-269316742.us-east-1.elb.amazonaws.com

### **Auto Scaling Group**
- **Name:** countries-asg
- **Launch Template:** Project-LT
- **Desired Capacity:** 2 instances
- **Minimum Capacity:** 2 instances
- **Maximum Capacity:** 4 instances
- **Availability Zones:** us-east-1a, us-east-1b
- **Subnets:** Private Subnet 1, Private Subnet 2
- **Health Checks:** ELB health checks enabled
- **Scaling Policy:** Target tracking scaling policy

### **Target Group**
- **Name:** countries-tg
- **Target Type:** Instances
- **Protocol:** HTTP
- **VPC:** Project VPC
- **Health Checks:** Enabled

---

## Security Configuration

### **Security Groups**

**ALBSG (Application Load Balancer Security Group)**
- Inbound: HTTP (80), HTTPS (443) from 0.0.0.0/0
- Outbound: All traffic to application instances

**Application Instance Security Group**
- Inbound: HTTP (80) from ALBSG only
- Outbound: MySQL (3306) to ExampleDB-SG

**ExampleDB-SG (Database Security Group)**
- Inbound: MySQL (3306) from application instances only
- Outbound: None

### **Secrets Management**
- **Service:** AWS Secrets Manager
- **Secret Name:** rds!db-[identifier]
- **Contents:** Database username and password (JSON format)
- **Access Method:** AWS CLI retrieval from EC2 instances

### **Remote Access**
- **Method:** AWS Systems Manager Session Manager
- **Benefit:** No SSH keys, no bastion host, full audit logging

---

## Deployment Timeline

| Time (UTC) | Action | Duration |
|------------|--------|----------|
| 2026-05-05 21:44:49 | Deployed and documented lab environment | ~10 min |
| 2026-05-05 21:54:44 | Created Amazon RDS MySQL database | ~24 min |
| 2026-05-05 23:18:33 | Created Target Group for ALB | ~12 min |
| 2026-05-05 23:30:32 | Configured and created Application Load Balancer | ~11 min |
| 2026-05-05 23:41:38 | Configured and created Auto Scaling Group | ~32 min |
| 2026-05-06 00:13:57 | Connected to instance and imported SQL data | ~53 min |
| 2026-05-06 01:06:29 | Tested ALB URL and web application | ~41 min |
| 2026-05-06 01:47:34 | Submitted project for grading | Complete |

**Total Deployment Time:** ~4 hours

---

## Key Commands Used

### **AWS Secrets Manager**

    # List secrets
    aws secretsmanager list-secrets --query "SecretList[*].Name" --output text

    # Retrieve secret value
    aws secretsmanager get-secret-value --secret-id '[secret-name]' --query SecretString --output text

### **MySQL Database Operations**

    # Import SQL data
    mysql -h [rds-endpoint] -u admin -p countries < /home/ec2-user/Countrydatadump.sql

    # Connect to database
    mysql -h [rds-endpoint] -u admin -p countries

    # Verify data
    SHOW TABLES;
    SELECT * FROM countrydata_final LIMIT 5;

### **Systems Manager Session Manager**

    # Switch to ec2-user
    sudo su - ec2-user

    # Download SQL data file
    wget https://aws-tc-largeobjects.s3.us-west-2.amazonaws.com/[path]/Countrydatadump.sql

---

## Architecture Highlights

✅ **Multi-AZ Deployment** - High availability across us-east-1a and us-east-1b  
✅ **Auto Scaling** - Dynamic capacity management (2-4 instances)  
✅ **Load Balancing** - Traffic distribution via Application Load Balancer  
✅ **Network Isolation** - Database in private subnets with no internet access  
✅ **Secrets Management** - AWS Secrets Manager for credential security  
✅ **Secure Access** - SSM Session Manager (no SSH keys)  
✅ **Health Checks** - Automatic instance replacement on failure  

---

## Lessons Learned

1. **Dependency Management:** Proper sequencing of resource deployment is critical (database → target group → load balancer → auto scaling group)

2. **AWS Secrets Manager Integration:** Seamless integration with RDS eliminates hardcoded credentials and simplifies credential rotation

3. **Systems Manager Session Manager:** Provides secure remote access without SSH key management or bastion host overhead

4. **Auto Scaling Health Checks:** ELB health checks ensure automatic instance replacement, improving application availability

5. **Multi-AZ Deployment:** Distributing resources across availability zones provides resilience against AZ-level failures

---

## Testing & Validation

✅ **Database Connectivity:** Verified MySQL connection from application instances  
✅ **Data Integrity:** Confirmed SQL data import and query functionality  
✅ **Load Balancer:** Tested ALB DNS resolution and traffic distribution  
✅ **Auto Scaling:** Verified 2/2 instances healthy and registered with target group  
✅ **Application Functionality:** Tested web application queries (Mobile Phones, Population)  
✅ **Secrets Retrieval:** Successfully retrieved database credentials from Secrets Manager  

---

## Project Outcome

**Grade:** 35/35 (100%)  
**Status:** Successfully completed  
**Architecture:** Production-ready, highly-available, secure multi-tier deployment  

---

*For detailed deployment steps and evidence, see [deployment-documentation.pdf](../reports/deployment-documentation.pdf)*
