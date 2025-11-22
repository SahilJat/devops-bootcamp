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
