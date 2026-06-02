# AWS ECS Fargate Full-Stack Application

A production-style full-stack application deployed on AWS using Infrastructure as Code (Terraform), containerized with Docker, and orchestrated using Amazon ECS Fargate.

## Project Overview

This project demonstrates the deployment of a modern full-stack application consisting of:

* **Frontend:** Next.js
* **Backend:** FastAPI
* **Containerization:** Docker
* **Container Registry:** Amazon ECR
* **Orchestration:** Amazon ECS Fargate
* **Load Balancing:** Application Load Balancer (ALB)
* **Infrastructure as Code:** Terraform
* **Logging:** Amazon CloudWatch
* **State Management:** Amazon S3 + DynamoDB

The goal of this project was to build and deploy a scalable cloud-native application while following DevOps best practices.

---

## Architecture

```text
Internet
    │
    ▼
Application Load Balancer (ALB)
    │
    ├── /                 → Frontend (Next.js)
    │
    └── /api/*            → Backend (FastAPI)

─────────────────────────────────────────

Frontend Service
    ├── ECS Fargate
    ├── Docker Container
    └── Amazon ECR

Backend Service
    ├── ECS Fargate
    ├── Docker Container
    └── Amazon ECR

─────────────────────────────────────────

Infrastructure
    ├── Terraform
    ├── Amazon VPC
    ├── Public Subnets
    ├── Internet Gateway
    ├── Route Tables
    ├── Security Groups
    └── CloudWatch Logs

Terraform State
    ├── Amazon S3
    └── DynamoDB Lock Table
```

---

## Features

### Frontend

* Built using Next.js
* Uses Axios to communicate with backend APIs
* Health-check verification before loading data
* Environment-based API configuration

### Backend

* Built using FastAPI
* REST API endpoints
* Health-check endpoint
* Containerized deployment

### Infrastructure

* Infrastructure provisioned using Terraform
* ECS Fargate serverless containers
* Application Load Balancer routing
* CloudWatch logging
* Remote Terraform state storage

---

## AWS Services Used

| Service                   | Purpose                                    |
| ------------------------- | ------------------------------------------ |
| Amazon ECS Fargate        | Run containers without managing servers    |
| Amazon ECR                | Store Docker images                        |
| Application Load Balancer | Route traffic between frontend and backend |
| Amazon VPC                | Networking                                 |
| Amazon CloudWatch         | Logs and monitoring                        |
| Amazon S3                 | Terraform remote state                     |
| Amazon DynamoDB           | Terraform state locking                    |
| IAM                       | ECS execution roles and permissions        |

---

## Project Structure

```text
frontend-backend-project/

├── backend/
│   ├── app/
│   ├── requirements.txt
│   └── Dockerfile
│
├── frontend/
│   ├── pages/
│   ├── package.json
│   └── Dockerfile
│
├── infrastructure/
│   └── aws/
│       └── dev/
│           ├── backend.tf
│           ├── provider.tf
│           ├── iam.tf
│           └── main.tf
│
└── README.md
```

---

## Deployment Workflow

### 1. Backend Deployment

```bash
docker build -t devops-backend .
docker push <ecr-backend-repository>
```

Deploy using Terraform:

```bash
terraform init
terraform plan
terraform apply
```

---

### 2. Frontend Deployment

```bash
docker build -t frontend-app .
docker push <ecr-frontend-repository>
```

Update ECS service:

```bash
aws ecs update-service \
  --cluster devops-cluster \
  --service frontend-service \
  --force-new-deployment
```

---

## API Endpoints

### Health Check

```http
GET /api/health
```

Response:

```json
{
  "status": "healthy"
}
```

### Message Endpoint

```http
GET /api/message
```

Response:

```json
{
  "message": "You've successfully integrated the backend!"
}
```

---

## Terraform Resources Created

* VPC
* Public Subnets
* Internet Gateway
* Route Tables
* Security Groups
* Application Load Balancer
* Target Groups
* Listener Rules
* ECS Cluster
* ECS Services
* ECS Task Definitions
* IAM Roles
* CloudWatch Log Groups

---

## Local Development

### Backend

```bash
cd backend

python -m venv venv

source venv/bin/activate

pip install -r requirements.txt

uvicorn app.main:app --reload --port 8000
```

### Frontend

```bash
cd frontend

npm install

npm run dev
```

Frontend:

```text
http://localhost:3000
```

Backend:

```text
http://localhost:8000
```

---

## Key Learnings

* Docker image creation and management
* Amazon ECR workflows
* ECS Fargate deployment patterns
* Application Load Balancer routing
* Terraform Infrastructure as Code
* Cloud-native networking concepts
* IAM roles and permissions
* Remote Terraform state management
* Full-stack application deployment on AWS

---

## Future Improvements

* HTTPS using ACM certificates
* Custom domain with Route 53
* CI/CD pipeline using GitHub Actions
* ECS auto-scaling policies
* Monitoring dashboards with CloudWatch
* Blue/Green deployments
* Multi-environment Terraform setup

---

## Author

**Kinshuk Totla**

Built as a cloud-native DevOps and AWS deployment project to demonstrate containerization, Infrastructure as Code, and production-style application deployment using Amazon ECS Fargate.
