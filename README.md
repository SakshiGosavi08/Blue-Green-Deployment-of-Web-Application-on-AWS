# Blue-Green Deployment of Web Application on AWS

## Project Overview
This project demonstrates the implementation of a **Blue-Green Deployment strategy on AWS**
to achieve zero-downtime application updates and quick rollback capability.

Two separate environments (Blue and Green) are created using EC2 instances, and
traffic is managed using an **Application Load Balancer (ALB)**.

---

## Objective
- Deploy a web application without service interruption
- Safely test a new application version before going live
- Enable instant rollback in case of issues

---

## AWS Services Used
- Amazon EC2
- Application Load Balancer (ALB)
- Target Groups
- Security Groups

---

## Architecture Description
- **Blue Environment**: Currently active/live version of the application
- **Green Environment**: New version of the application
- **Application Load Balancer**: Routes and switches traffic between Blue and Green environments

---

## Security Group Rules
### EC2 Security Group
- HTTP (Port 80) – Allowed only from Load Balancer Security Group
- SSH (Port 22) – Allowed from my IP address (administration purpose)

### Load Balancer Security Group
- HTTP (Port 80) – Allowed from anywhere (0.0.0.0/0)

---

## Load Balancer Traffic Switching Process
1. Two target groups are created:
   - Target Group (Blue) – attached to Blue EC2 instances
   - Target Group (Green) – attached to Green EC2 instances
2. Initially, the Application Load Balancer forwards 100% traffic to the Blue target group.
3. The Green environment is deployed using EC2 user-data scripts and tested.
4. After validation, the ALB listener rule is modified to switch traffic from Blue to Green.
5. If any issue occurs, rollback is performed by redirecting traffic back to the Blue target group.

This process ensures **zero-downtime deployments**.

---

## EC2 User Data & Script Automation
EC2 instances are launched with **user-data scripts** to automate the entire setup process.

The user-data script performs the following tasks:
- Installs the required web server (httpd)
- Starts and enables the web service
- Executes application deployment scripts automatically during instance launch

The application deployment scripts are **included inside the user-data configuration**
and are executed at EC2 launch time without any manual intervention.

Two separate user-data scripts are used:
- One script deploys the **Blue version** of the web application
- One script deploys the **Green version** of the web application

---

## Web Application Deployment
- The web application files are downloaded automatically on the EC2 instances
  using shell scripts executed through user-data.
- These scripts fetch the required web application files and deploy them
  to the web server directory (`/var/www/html`).

This approach ensures consistent and automated deployments.

---

## Deployment Flow Summary
1. Launch EC2 instances for Blue and Green environments
2. Configure Security Groups and Target Groups
3. Attach EC2 instances to their respective target groups
4. Configure Application Load Balancer and listener rules
5. Deploy applications using EC2 user-data scripts
6. Switch traffic between environments using ALB
7. Roll back traffic if needed

---

## Outcome
- Zero-downtime application deployment achieved
- Safe and controlled release of new application version
- Quick rollback supported through load balancer configuration

---

## Notes
- AWS credentials, key pairs, and sensitive information are **not included** for security reasons.
- This project focuses on demonstrating deployment strategy and cloud architecture concepts.
