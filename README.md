# 🚀 DevOps Project: Node.js, Docker, Terraform, CI/CD & Monitoring

## 📌 Overview

This project demonstrates a complete DevOps workflow including infrastructure provisioning, containerized application deployment, CI/CD automation, and monitoring.

---

## 🏗️ Infrastructure Setup (Terraform)

The infrastructure is fully provisioned using Terraform on AWS.

### Components:

* VPC (ap-south-1)
* Public Subnet → EC2
* Private Subnet → RDS
* Internet Gateway
* Route Tables

### Services:

* EC2 (Node.js Application)
* RDS PostgreSQL (Private)
* ECR (Docker Registry)

---

## 🐳 Run the Application

We can easily run the whole application using Docker Compose:

```bash
docker compose up -d
```

This will start:

* Node.js backend
* React frontend
* PostgreSQL database

---

## 🐳 Docker Setup

### Build Image

```bash
docker build -t app .
```

### Push to ECR

```bash
docker tag app:latest <ECR_URL>
docker push <ECR_URL>
```

---

## 🔁 CI/CD Pipeline

### CI (Continuous Integration)

* Build application
* Run tests
* Build Docker image
* Push to ECR

### CD (Continuous Deployment)

* Pull latest image from ECR
* Update docker-compose
* Restart containers on EC2

---

## 🚀 Deploy Infrastructure

```bash
terraform init
terraform apply
```

---

## 📊 Monitoring

### CloudWatch

* EC2 CPU usage
* Logs monitoring

### Prometheus + Grafana

* Node Exporter installed on EC2
* System metrics dashboards:

  * CPU
  * Memory
  * Disk

---

## ❤️ Uptime Monitoring

### Uptime Kuma

* Monitors application uptime
* Sends alerts on downtime

---

## 🔐 Security

* RDS in private subnet (no public access)
* EC2 access restricted via Security Groups
* SSH allowed only from personal IP
* HTTPS (443) exposed for application

---

## 📁 Project Structure

```
terraform/
docker/
app/
.github/workflows/
```

---

## 👤 Author

**Dimpy Khatwani**
DevOps Engineer

---
