# 🚀 DevOps Engineer Roadmap (3-Month Journey)

This repository documents my journey from Full Stack Developer to DevOps Engineer. It contains automation scripts, infrastructure-as-code configurations, and deployment logs.

## 📅 Daily Progress Log

### **Day 1: Linux Automation & Containerization**
**Goal:** Move from manual "Localhost" development to automated, isolated server environments.

#### **1. Bash Scripting (`setup.sh`)**
Created a script to automate the initialization of project environments.
- **Features:**
  - Checks for necessary dependencies (`node`, `git`).
  - Uses Exit Codes to fail safely if tools are missing.
  - Automates directory structure creation (`frontend`/`backend`).

#### **2. Manual Process Management**
- Explored Linux process handling.
- Used `lsof -i :3000` to identify processes listening on ports.
- Used `kill -9 <PID>` to terminate stuck applications surgically.

#### **3. The "Local Cloud" (Docker Simulation)**
Simulated an AWS EC2 environment locally using Docker to practice server provisioning without cloud costs.
- **Command Used:**
```basgh
  docker run -dt --name my-production-server -p 8080:3000 ubuntu:latest

Provisioning:

        Manually installed Node.js v20, Git, and Curl inside the raw Ubuntu container.

        Deployed a Next.js application listening on 0.0.0.0 to expose it to the host network.

🔧 Troubleshooting & Wins

Issue: npm install failed with EAI_AGAIN (DNS Error) inside the Docker container.

    Root Cause: The container could not resolve registry.npmjs.org due to missing DNS configurations in WSL/Docker.

    Solution: Manually patched the DNS resolver:
    Bash

echo "nameserver 8.8.8.8" > /etc/resolv.conf

Outcome: Successfully deployed the application, accessible via http://localhost:8080.

---

### **Day 2: CI/CD Pipeline Automation**
**Goal:** Eliminate manual testing and deployment by implementing a continuous integration pipeline.

#### **1. GitHub Actions Workflow (`ci.yml`)**
Built a dual-stage pipeline triggered on `push` to main.
- **Job 1: Build & Test**
  - Automates `npm install` and `npm run build` on a fresh Ubuntu runner.
  - acts as a Quality Gate: If the build fails, the deployment is blocked.
- **Job 2: Docker Delivery**
  - Authenticates with Docker Hub using **GitHub Secrets** (Secure credential management).
  - Builds the Docker image and pushes it to the registry (`<your-username>/devops-bootcamp`).

#### **2. Pipeline Optimization**
- **Smart Triggers:** Implemented `paths-ignore` to prevent the pipeline from running on documentation changes (`*.md`), saving build minutes.
- **Build Context Optimization:** Created a `.dockerignore` file to exclude `node_modules` and `.git`, reducing image build context from ~200MB to <1MB.

---

### **Day 3: Deployment, Orchestration & Load Balancing**
**Goal:** Simulate a production-grade cloud deployment with fault tolerance and scalability.

#### **1. Automated Deployment Script (`deploy.sh`)**
Created a shell script to simulate a "Blue/Green" style deployment on a server.
- **Features:**
  - Pulls the latest image from Docker Hub.
  - Gracefully stops and removes conflicting containers.
  - Implements `--restart always` policy to ensure the app survives server reboots.

#### **2. Reverse Proxy Implementation (Nginx)**
- Deployed Nginx as a gateway to hide the application port (3000) behind standard HTTP (80).
- Configured custom routing in `nginx-conf/default.conf` using Docker's internal DNS resolution.

#### **3. Orchestration & Load Balancing**
- **Tool:** Docker Compose (`docker-compose.yml`).
- **Architecture:** 3-Tier Microservices (Client -> Proxy -> App Cluster).
- **High Availability:**
  - Scaled the application to **3 Replicas** using `docker compose up --scale web-app=3`.
  - Verified **Round-Robin Load Balancing** where Nginx distributes traffic across all 3 containers.
  - Tested **Fault Tolerance** by manually killing containers and verifying zero downtime.

---
