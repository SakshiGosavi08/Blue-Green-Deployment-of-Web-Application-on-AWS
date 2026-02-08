# Blue-Green Deployment of Web Application on AWS

## Project Overview
This project demonstrates the implementation of the **Blue-Green Deployment strategy on AWS**
to achieve **zero-downtime application deployment** and quick rollback.

The strategy is implemented using:
- EC2 with Application Load Balancer (manual traffic switching)
- Elastic Beanstalk with environment swap feature

---

## Objective
- Deploy applications without downtime
- Safely release new versions
- Practice Blue-Green deployment using multiple AWS approaches
- Understand traffic switching and rollback mechanisms

---

## AWS Services Used
- Amazon EC2
- Application Load Balancer (ALB)
- Target Groups
- Security Groups
- Elastic Beanstalk

---

## Architecture Description (EC2 + ALB)
- **Blue Environment**: Current live version of the application
- **Green Environment**: New version of the application
- **Application Load Balancer**: Manages traffic switching between environments

---

## Security Group Rules
### EC2 Security Group
- HTTP (Port 80) – Allowed only from Load Balancer Security Group
- SSH (Port 22) – Allowed from my IP address

### Load Balancer Security Group
- HTTP (Port 80) – Allowed from anywhere (0.0.0.0/0)

---

## Load Balancer Traffic Switching (EC2 Based)
1. Two target groups are created:
   - Target Group (Blue)
   - Target Group (Green)
2. Initially, ALB forwards 100% traffic to the Blue environment.
3. The Green environment is deployed and tested.
4. ALB listener rules are updated to switch traffic to Green.
5. Rollback is done by redirecting traffic back to Blue if required.

This ensures **zero-downtime deployment**.

---

## EC2 User Data & Script Automation
EC2 instances are launched using **user-data scripts** to automate setup.

The user-data scripts:
- Install web server (httpd)
- Start and enable the service
- Download and deploy application files automatically

Application deployment scripts are **embedded within the user-data configuration**
and execute automatically at EC2 launch.

Two separate user-data scripts are used:
- One for Blue version deployment
- One for Green version deployment

---

## Web Application Deployment (EC2)
- Application files are downloaded using shell scripts
- Files are deployed automatically to `/var/www/html`
- No manual deployment is required

---

## Elastic Beanstalk Blue-Green Deployment
The same application is also deployed using **Elastic Beanstalk** to implement
Blue-Green deployment with **different technology stacks**.

### Elastic Beanstalk Environments
- **Environment 1**: Apache Tomcat environment
- **Environment 2**: Python environment

Both environments are created separately under Elastic Beanstalk.

---

## Elastic Beanstalk Environment Swap Process
1. The application is deployed in the first Elastic Beanstalk environment.
2. A second environment is created with a different platform (Tomcat / Python).
3. The new environment is tested independently.
4. **Environment URL swap** feature is used to swap traffic between environments.
5. Website continues to run without downtime during the swap.

This achieved **zero-downtime deployment** using Elastic Beanstalk.

---

## Deployment Flow Summary
1. EC2 Blue & Green environments launched
2. Applications deployed using user-data scripts
3. Traffic managed using Application Load Balancer
4. Elastic Beanstalk environments created with different stacks
5. Application deployed and tested in both EB environments
6. Environment swap performed in Elastic Beanstalk
7. Zero downtime observed in both approaches

---

## Outcome
- Zero-downtime deployment achieved
- Blue-Green strategy implemented using two AWS services
- Experience gained with Load Balancer switching and Elastic Beanstalk swaps
- Improved understanding of deployment strategies

---

## Notes
- AWS credentials, keys, and sensitive information are not included
- This project focuses on learning deployment strategies and cloud architecture
