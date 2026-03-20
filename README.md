# terraform-aws-prod
# 🚀 Terraform AWS Production Infrastructure (End-to-End DevOps Project)

This project demonstrates how to build a **production-ready AWS infrastructure** using **Terraform** and automate deployments with **GitHub Actions (CI/CD)**.

---

## 📌 📖 Project Overview

In this project, I designed and deployed a **secure, scalable, and production-grade architecture** on AWS using Infrastructure as Code (IaC).

---

## 🔧 Technologies Used

* Terraform (Infrastructure as Code)
* AWS (VPC, EC2, ALB, NAT Gateway, Auto Scaling)
* Git & GitHub
* GitHub Actions (CI/CD)
* Nginx (Application Server)

---

## 🏗️ Architecture

```
Internet 🌐
   ↓
Application Load Balancer (ALB)
   ↓
Target Group
   ↓
Auto Scaling Group (Private EC2 Instances)
   ↓
Nginx Application
   ↓
NAT Gateway → Internet Access
   ↓
Bastion Host (Secure SSH Access)
```

---

## 📁 Project Structure

```
terraform-aws-prod/
│
├── modules/
│   ├── vpc/
│   ├── ec2/
│   ├── alb/
│   ├── bastion/
│   └── rds/
│
├── main.tf
├── variables.tf
├── outputs.tf
├── provider.tf
├── backend.tf
└── .gitignore
```

---

## ⚙️ Key Features

✔ Custom VPC with Public & Private Subnets
✔ Bastion Host for secure SSH access
✔ NAT Gateway for private EC2 internet access
✔ Auto Scaling Group for high availability
✔ Application Load Balancer for traffic distribution
✔ Nginx deployed on private EC2 instances
✔ CI/CD pipeline using GitHub Actions

---

## 🚀 Step-by-Step Setup

### 1️⃣ Clone the repository

```
git clone https://github.com/<your-username>/terraform-aws-prod.git
cd terraform-aws-prod
```

---

### 2️⃣ Configure AWS Credentials

```
aws configure
```

Enter:

* AWS Access Key
* AWS Secret Key
* Region (e.g., ap-south-1)

---

### 3️⃣ Initialize Terraform

```
terraform init
```

---

### 4️⃣ Validate Configuration

```
terraform validate
```

---

### 5️⃣ Plan Infrastructure

```
terraform plan
```

---

### 6️⃣ Deploy Infrastructure

```
terraform apply
```

Type:

```
yes
```

---

### 7️⃣ Access Application

* Go to AWS Console → EC2 → Load Balancers
* Copy DNS name
* Open in browser

👉 Expected Output:

```
Welcome to nginx!
```

---

## 🔐 Security Best Practices

* Private EC2 instances (no public IP)
* Bastion Host for SSH access
* Security Groups properly configured
* Sensitive files excluded using `.gitignore`

---

## 🔄 CI/CD Pipeline (GitHub Actions)

### 📄 Workflow File

```
.github/workflows/terraform.yml
```

---

### 🚀 Pipeline Flow

```
Code Push → GitHub Actions → Terraform Init → Plan → Apply → AWS Deployment
```

---

## 🧪 Testing

### 🔹 SSH into Bastion

```
ssh -i my-key.pem ubuntu@<bastion-public-ip>
```

---

### 🔹 SSH into Private EC2

```
ssh -i my-key.pem ubuntu@<private-ip>
```

---

### 🔹 Test Internet Access

```
ping google.com
```

---

### 🔹 Test Nginx

```
curl localhost
```

---

## 🚨 Troubleshooting Guide

---

### ❌ SSH Permission Denied

```
chmod 400 my-key.pem
```

---

### ❌ Cannot SSH Private EC2

* Ensure key is added in Launch Template
* Check Security Groups (Bastion → EC2 access)

---

### ❌ ALB Not Working

* Check Target Group health
* Ensure port 80 is open
* Verify Nginx is running

---

### ❌ Target Group In Use Error

```
terraform apply -replace="module.alb.aws_lb"
```

---

### ❌ Terraform Variable Errors

* Define variables in `variables.tf`
* Add outputs in `outputs.tf`

---

### ❌ CI/CD Pipeline Fails

* Check GitHub Secrets
* Verify AWS credentials
* Ensure IAM permissions

---

## 🧠 Learnings

✔ Infrastructure as Code (Terraform)
✔ AWS Networking (VPC, Subnets, NAT Gateway, ALB)
✔ Secure Architecture Design
✔ Debugging real-world DevOps issues
✔ CI/CD automation using GitHub Actions

---

## 📌 Resume Highlights

* Designed and deployed production-grade AWS infrastructure using Terraform
* Implemented secure architecture using private EC2 and Bastion host
* Built scalable system using Auto Scaling and Load Balancer
* Automated infrastructure deployment using GitHub Actions CI/CD

---

## 💰 Cost Management

To avoid AWS charges, destroy resources after use:

```
terraform destroy
```

---

## 🚀 Future Enhancements

* Add HTTPS using ACM (SSL Certificates)
* Deploy Node.js / React application
* Dockerize application
* Use ECS or Kubernetes
* Add monitoring (CloudWatch, Prometheus)

---

## 🤝 Contributing

Feel free to fork and improve this project!

---

## ⭐ Support

If you found this project helpful:

⭐ Star the repository
🔗 Connect with me on LinkedIn

---

## 🚀 Final Note

This project replicates a **real-world production DevOps setup** and demonstrates how modern infrastructure is built, automated, and managed using Terraform and CI/CD pipelines.

---
