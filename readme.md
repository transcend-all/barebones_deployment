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

All three nodehttps://github.com/transcend-all/barebones_deployments are connected using internal private IPs within a VPC. Security groups are configured to allow only required traffic.

---

## 🚀 Deployment Instructions

### 1. Clone and initialize

```bash
git clone https://github.com/your-org/your-repo.git
cd your-repo

* * * * *

```
## 2. Deploy Infrastructure with Terraform

```bash
terraform init
terraform apply

```

This will:

-   Launch 3 EC2 instances

-   Output their IPs to `tf_outputs.json`

* * * * *

3\. Update Ansible Inventory
----------------------------

Manually or with a script, update `inventory.ini` using values from `tf_outputs.json`.

Example format:

```
[frontend]
<frontend_public_ip> ansible_user=ec2-user ansible_ssh_private_key_file=~/Downloads/your-key.pem

[backend]
<backend_public_ip> ansible_user=ec2-user ansible_ssh_private_key_file=~/Downloads/your-key.pem

[database]
<database_public_ip> ansible_user=ec2-user ansible_ssh_private_key_file=~/Downloads/your-key.pem

```

* * * * *

4\. Run Ansible Playbooks
-------------------------

```
ansible-playbook -i inventory.ini database.yml
ansible-playbook -i inventory.ini backend.yml
ansible-playbook -i inventory.ini frontend.yml

```

* * * * *

🧪 Verification
---------------

Visit the frontend in your browser:

```
http://<frontend_public_ip>:8080

```

You should see the following message:

```
Hello from the database!

```

* * * * *

📁 Directory Structure
----------------------

```
.
├── backend/             # Flask app (templated via app.py.j2)
├── frontend/            # index.html.j2 + CSS assets
├── templates/           # Ansible Jinja2 templates
├── tf_outputs.json      # Terraform output consumed by Ansible
├── terraform/           # Terraform config files
├── inventory.ini        # Ansible static inventory
├── database.yml         # Ansible playbook for PostgreSQL
├── backend.yml          # Ansible playbook for Flask app
├── frontend.yml         # Ansible playbook for frontend server
└── README.md

```

* * * * *

🛠️ Troubleshooting
-------------------

-   **500 Internal Server Error?**\
    Check Flask logs in `~/backend/nohup.out` on the backend node

-   **Database connection refused?**\
    Ensure:

    -   PostgreSQL is listening on `0.0.0.0:5432`

    -   Security group allows access from backend

    -   `pg_hba.conf` permits remote connections

* * * * *

🧼 Teardown
-----------

To remove all resources:

```
terraform destroy

```

* * * * *

📄 License
----------

MIT License
