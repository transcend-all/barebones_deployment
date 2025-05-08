# Minimal 3-Tier Application Deployment with Terraform and Ansible

This repository contains a fully automated deployment of a minimal 3-tier application across three EC2 instances using **Terraform** for provisioning and **Ansible** for configuration.

---

## 📦 Stack

- **Frontend:** Static HTML/CSS served via Python’s built-in HTTP server  
- **Backend:** Python Flask API connecting to a PostgreSQL database  
- **Database:** PostgreSQL

---

## 🧱 Architecture

- `frontend` EC2: Serves static website with embedded API call  
- `backend` EC2: Flask app exposing `/api/message`  
- `database` EC2: PostgreSQL storing and serving the message content  

All three nodes are connected using internal private IPs within a VPC. Security groups are configured to allow only required traffic.

---

## 🚀 Deployment Instructions

### 1. Clone and initialize

```bash
git clone https://github.com/your-org/your-repo.git
cd your-repo
