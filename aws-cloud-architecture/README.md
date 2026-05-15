# AWS Cloud Architecture - Highly Available Multi-Tier Application

## Project Overview

Architected and deployed a production-ready, highly-available cloud infrastructure on Amazon Web Services (AWS) implementing security best practices for a multi-tier web application with MySQL database backend. Transformed a single-instance deployment into a secure, scalable architecture with VPC segmentation, secrets management, auto-scaling, and load balancing.

**Organization:** Example Social Research Organization (Fictitious)  
**Application:** PHP-based web application providing global development statistics (life expectancy, mobile phone usage) for social science researchers  
**Objective:** Migrate from single-instance architecture to highly-available, secure, multi-tier cloud deployment

---

## 🏗️ Architecture Components

### **Network Architecture**
- **VPC Design:** Multi-subnet architecture with public/private subnet separation across multiple availability zones
- **Availability Zones:** us-east-1a, us-east-1b (multi-AZ deployment for high availability)
- **Public Subnets:** Host Application Load Balancer for internet-facing traffic
- **Private Subnets:** Host application instances and RDS database (no direct internet access)

### **Database Tier**
- **Service:** Amazon RDS MySQL
- **Configuration:** Single-AZ deployment (Dev/Test template)
- **Instance Class:** db.t3.micro (burstable performance)
- **Storage:** 20 GiB allocated storage
- **Security:** AWS Secrets Manager integration (no hardcoded credentials)
- **Network Isolation:** Deployed in private subnets with security group restrictions

### **Application Tier**
- **Compute:** EC2 instances launched via Auto Scaling Group
- **Auto Scaling Configuration:**
  - Desired Capacity: 2 instances
  - Minimum Capacity: 2 instances
  - Maximum Capacity: 4 instances
  - Scaling Policy: Target tracking scaling policy
- **Health Checks:** Elastic Load Balancing health checks enabled
- **Network Placement:** Private subnets (us-east-1a, us-east-1b)

### **Load Balancing**
- **Service:** Application Load Balancer (ALB)
- **Configuration:** Internet-facing, cross-zone load balancing
- **Target Group:** countries-tg (instance targets)
- **Health Checks:** Configured for application availability monitoring
- **Network Placement:** Public subnets across multiple availability zones

### **Secure Access**
- **Method:** AWS Systems Manager Session Manager (SSM)
- **Benefit:** No SSH key exposure, no bastion host required
- **Audit:** All session activity logged to CloudTrail

### **Secrets Management**
- **Service:** AWS Secrets Manager
- **Purpose:** Secure storage and retrieval of RDS database credentials
- **Integration:** Automatic credential rotation support
- **Access Method:** AWS CLI retrieval from EC2 instances

---

## 🔒 Security Best Practices Implemented

✅ **Secrets Management**
- AWS Secrets Manager for database credentials (no hardcoded passwords)
- Automatic credential rotation capability
- IAM-based access control for secret retrieval

✅ **Least Privilege Access**
- Security groups configured with minimal required access
- Database security group (ExampleDB-SG) restricts access to application tier only
- Application Load Balancer security group (ALBSG) allows only HTTP/HTTPS traffic

✅ **Defense in Depth**
- Multi-layer architecture with isolated database tier
- Private subnets for application and database (no direct internet access)
- Public subnets only for load balancer (internet-facing component)

✅ **High Availability**
- Multi-AZ deployment across us-east-1a and us-east-1b
- Auto Scaling Group ensures minimum 2 instances always running
- Application Load Balancer distributes traffic across healthy instances
- Automatic failover if instance becomes unhealthy

✅ **Secure Remote Access**
- AWS Systems Manager Session Manager instead of SSH
- No SSH keys to manage or expose
- All session activity logged and auditable

✅ **Network Segmentation**
- VPC with public/private subnet architecture
- Database isolated in private subnets (no internet route)
- Application tier in private subnets (outbound internet via NAT Gateway)
- Load balancer in public subnets (internet-facing)

---

## 📋 Deployment Process

### **Phase 1: Database Deployment**
1. Created Amazon RDS MySQL database (countries-db)
2. Configured AWS Secrets Manager for credential storage
3. Deployed database in private subnets with ExampleDB-SG security group
4. Verified database availability and connectivity

### **Phase 2: Load Balancing Configuration**
1. Created target group (countries-tg) for application instances
2. Deployed Application Load Balancer (countries-alb) in public subnets
3. Configured health checks and routing rules
4. Verified load balancer DNS resolution

### **Phase 3: Auto Scaling Deployment**
1. Created Auto Scaling Group (countries-asg) using provided launch template
2. Configured desired/min/max capacity (2/2/4 instances)
3. Attached Auto Scaling Group to Application Load Balancer target group
4. Enabled ELB health checks for automatic instance replacement
5. Verified 2/2 instances healthy and registered with load balancer

### **Phase 4: Database Population**
1. Connected to application instance via AWS Systems Manager Session Manager
2. Retrieved database credentials from AWS Secrets Manager using AWS CLI
3. Downloaded SQL data file (Countrydatadump.sql) from S3
4. Imported data into countries-db database using MySQL CLI
5. Verified data integrity with SQL queries

### **Phase 5: Application Testing**
1. Accessed application via Application Load Balancer DNS name
2. Tested query functionality (Mobile Phones, Population statistics)
3. Verified load balancer distributing traffic across instances
4. Confirmed database connectivity and query responses

---

## 🎯 Key Achievements

✅ **Transformed single-instance deployment into highly-available architecture**
- Eliminated single point of failure through multi-AZ deployment
- Implemented auto-scaling for dynamic capacity management
- Deployed load balancing for traffic distribution

✅ **Implemented security best practices**
- Eliminated hardcoded credentials using AWS Secrets Manager
- Isolated database in private subnets with no internet access
- Configured least-privilege security groups
- Deployed secure remote access via SSM Session Manager

✅ **Achieved production-ready architecture**
- Multi-tier design with clear separation of concerns
- High availability across multiple availability zones
- Auto-scaling for elasticity and cost optimization
- Centralized secrets management for credential security

✅ **Demonstrated AWS proficiency**
- VPC design and subnet architecture
- RDS database deployment and configuration
- Application Load Balancer setup and target group management
- Auto Scaling Group configuration and health check integration
- AWS CLI usage for secrets retrieval and database operations
- Systems Manager Session Manager for secure instance access

---

## 📊 Architecture Diagram

### **VPC Architecture:**

    Internet
        |
        v
    [Application Load Balancer] (Public Subnets: us-east-1a, us-east-1b)
        |
        v
    [Auto Scaling Group] (Private Subnets: us-east-1a, us-east-1b)
        |-- EC2 Instance 1 (us-east-1a)
        |-- EC2 Instance 2 (us-east-1b)
        |
        v
    [Amazon RDS MySQL] (Private Subnets: us-east-1a, us-east-1b)
        |-- countries-db
        |-- Credentials: AWS Secrets Manager

### **Security Group Architecture:**

    ALBSG (Application Load Balancer Security Group)
        |-- Inbound: HTTP (80), HTTPS (443) from 0.0.0.0/0
        |-- Outbound: All traffic to application instances

    Application Instance Security Group
        |-- Inbound: HTTP (80) from ALBSG only
        |-- Outbound: MySQL (3306) to ExampleDB-SG

    ExampleDB-SG (Database Security Group)
        |-- Inbound: MySQL (3306) from application instances only
        |-- Outbound: None (database does not initiate outbound connections)

---

## 🛠️ Technologies & Services Used

### **AWS Services:**
- Amazon VPC (Virtual Private Cloud)
- Amazon EC2 (Elastic Compute Cloud)
- Amazon RDS (Relational Database Service) - MySQL
- Elastic Load Balancing (Application Load Balancer)
- Auto Scaling Groups
- AWS Secrets Manager
- AWS Systems Manager (Session Manager)
- AWS CLI (Command Line Interface)

### **Application Stack:**
- PHP (Web application)
- MySQL (Database)
- Apache/Nginx (Web server)

### **Tools & Utilities:**
- AWS Management Console
- AWS CLI
- MySQL CLI
- wget (file download)

---

## 📁 Project Artifacts

### **Deployment Documentation**
- **[Full Deployment Documentation (PDF)](./reports/deployment-documentation.pdf)** - Complete lab report with step-by-step deployment process, evidence log, and lessons learned
- **[Deployment Notepad (PDF)](./reports/deployment-notepad.pdf)** - Detailed environment documentation, actions taken, and evidence screenshots

### **Configuration Summary**
- **[Deployment Summary (Markdown)](./configuration/deployment-summary.md)** - Quick-view summary of all AWS resources and configurations

### **Architecture Diagrams**
- **[Architecture Diagram (PNG)](./diagrams/architecture-diagram.png)** - Visual representation of VPC, subnets, and resource placement *(if available)*

---

## 🎓 Skills Demonstrated

✅ **Cloud Security Architecture**
- VPC design with public/private subnet segmentation
- Security group configuration with least-privilege access
- Secrets management and credential protection
- Network isolation and defense-in-depth principles

✅ **High Availability Design**
- Multi-AZ deployment across availability zones
- Auto Scaling Group configuration for elasticity
- Application Load Balancer for traffic distribution
- Health check configuration for automatic failover

✅ **AWS Service Integration**
- RDS database deployment and configuration
- Secrets Manager integration with RDS
- Auto Scaling Group integration with Application Load Balancer
- Systems Manager Session Manager for secure access

✅ **Infrastructure as Code Concepts**
- Launch template usage for consistent instance deployment
- Auto Scaling Group configuration for automated scaling
- Target group and load balancer configuration

✅ **AWS CLI Proficiency**
- Secrets Manager CLI commands for credential retrieval
- MySQL CLI for database operations
- Systems Manager Session Manager for remote access

✅ **Database Management**
- RDS MySQL deployment and configuration
- SQL data import and validation
- Database connectivity testing and troubleshooting

✅ **Technical Documentation**
- Detailed deployment process documentation
- Evidence collection and logging
- Architecture diagram creation
- Lessons learned and best practices documentation

---

## 📚 AWS Best Practices Applied

### **Security:**
- ✅ Use AWS Secrets Manager for credential storage (no hardcoded passwords)
- ✅ Deploy databases in private subnets with no internet access
- ✅ Configure security groups with least-privilege access
- ✅ Use IAM roles for EC2 instance permissions (no access keys)
- ✅ Enable CloudTrail logging for audit and compliance

### **High Availability:**
- ✅ Deploy across multiple availability zones
- ✅ Use Auto Scaling Groups for automatic instance replacement
- ✅ Configure health checks for automatic failover
- ✅ Use Application Load Balancer for traffic distribution

### **Operational Excellence:**
- ✅ Use Systems Manager Session Manager for secure remote access
- ✅ Document all deployment steps and configurations
- ✅ Implement automated scaling policies
- ✅ Use managed services (RDS, ALB) to reduce operational overhead

### **Cost Optimization:**
- ✅ Use Auto Scaling to match capacity with demand
- ✅ Select appropriate instance types (db.t3.micro for dev/test)
- ✅ Use single-AZ RDS for non-production workloads

---

## 🔗 External Resources

### **AWS Documentation**
- **[Amazon VPC User Guide](https://docs.aws.amazon.com/vpc/)** - VPC design and subnet architecture
- **[Amazon RDS User Guide](https://docs.aws.amazon.com/rds/)** - RDS deployment and configuration
- **[Elastic Load Balancing User Guide](https://docs.aws.amazon.com/elasticloadbalancing/)** - ALB setup and configuration
- **[Amazon EC2 Auto Scaling User Guide](https://docs.aws.amazon.com/autoscaling/)** - Auto Scaling Group configuration
- **[AWS Secrets Manager User Guide](https://docs.aws.amazon.com/secretsmanager/)** - Secrets management best practices

### **AWS Well-Architected Framework**
- **[Security Pillar](https://docs.aws.amazon.com/wellarchitected/latest/security-pillar/)** - Security best practices
- **[Reliability Pillar](https://docs.aws.amazon.com/wellarchitected/latest/reliability-pillar/)** - High availability design

---

## 📝 Project Information

**Course:** CNG 2042 - Cloud Computing  
**Institution:** Pikes Peak State College  
**Completion Date:** May 2026  
**Author:** Ryan Verrot  
**Grade:** 35/35 (100%)

This AWS Cloud Architecture project demonstrates practical application of cloud security, high availability design, and AWS service integration skills required for Cloud Security Engineer, Cloud Architect, and DevOps Engineer roles.

All deployment activities were conducted in the AWS Academy lab environment using temporary credentials and simulated production scenarios.

---

*Deployment Completed: May 2026*  
*AWS Services: VPC, EC2, RDS, ALB, Auto Scaling, Secrets Manager, Systems Manager*  
*Architecture: Multi-tier, highly-available, secure cloud deployment*
