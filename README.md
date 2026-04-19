# 🚀 ChatOps AI Platform — Terraform Infrastructure

---

## 🧠 Overview

This repository contains the Terraform setup used to provision the AWS infrastructure for the ChatOps AI Platform.

While building the application, I didn’t want to rely on manual setup in AWS. So I structured this repo to manage everything using Terraform — including networking, IAM, and the EKS cluster.

The setup is split into two layers to keep things clean and reusable:

- Bootstrap layer → sets up remote backend (S3 + DynamoDB)  
- Environment layer → provisions actual infrastructure (EKS, VPC, etc.)  

---

## 📁 Project Structure

```
chatops-ai-platform-infra/
│
├── bootstrap/
│   └── backend-state/
│       ├── main.tf
│       ├── provider.tf
│       ├── variables.tf
│       └── outputs.tf
│
├── environments/
│   └── dev/
│       ├── main.tf
│       ├── provider.tf
│       ├── variables.tf
│       ├── terraform.tfvars.example
│       └── outputs.tf
│
└── .gitignore
```

---

## ⚙️ Prerequisites

- Terraform ≥ 1.5  
- AWS CLI configured (`aws configure`)  
- IAM permissions for:
  - S3  
  - DynamoDB  
  - EKS  
  - VPC  

---

## 🔐 Important Notes

The following files are intentionally ignored:

- `.terraform/`  
- `terraform.tfstate`  
- `terraform.tfvars`  

This avoids leaking state data and sensitive values.

---

## 🧱 Step 1 — Bootstrap Backend (Run once)

Before deploying infrastructure, I created a remote backend.

This step provisions:

- S3 bucket → stores Terraform state  
- DynamoDB table → handles state locking  

```bash
cd bootstrap/backend-state

terraform init
terraform apply
```

---

## 🌍 Step 2 — Deploy Environment (Dev)

Once backend is ready, infrastructure can be deployed.

```bash
cd environments/dev

terraform init
terraform plan
terraform apply
```

This step creates:

- VPC (public + private subnets)  
- Internet Gateway + NAT Gateway  
- Route tables  
- EKS cluster  
- Node group (worker nodes)  
- IAM roles and policies  

---

## 🔁 Step 3 — Destroy Infrastructure

To clean up resources and avoid AWS costs:

```bash
terraform destroy
```

---

## 🔧 Variables

Instead of hardcoding values, I used `terraform.tfvars`.

```bash
cp terraform.tfvars.example terraform.tfvars
vim terraform.tfvars
```

This makes it easier to manage different environments.

---

## 🧠 Terraform Concepts Used

- Remote backend (S3)  
- State locking (DynamoDB)  
- Modular structure  
- Environment-based deployment  
- Provider versioning  

---

## ⚠️ Best Practices Followed

- Always ran `terraform plan` before `apply`  
- Never committed state files  
- Used separate environment structure (`dev`, can extend to `prod`)  
- Used remote backend instead of local state  

---

## ⚠️ Challenges I faced

### VPC deletion issues

- `terraform destroy` was failing  
- Root cause → dependent resources like NAT Gateway and ENIs  

Fix:
- Identified dependencies using AWS CLI  
- Removed resources manually before destroy  

---

### Subnet tagging issues

- ALB was not getting created in EKS  

Root cause:
- Missing required subnet tags  

Fix:

```
kubernetes.io/role/elb = 1
kubernetes.io/role/internal-elb = 1
```

---

### IAM / EKS permission issues

- EKS components failed during setup  

Root cause:
- Incorrect IAM roles / trust relationships  

Fix:
- Updated IAM role policies  
- Verified OIDC provider configuration  

---

## 🧪 Useful Troubleshooting Commands

```bash
# Check VPC
aws ec2 describe-vpcs

# Check subnets
aws ec2 describe-subnets

# Check load balancers
aws elbv2 describe-load-balancers

# Check network interfaces
aws ec2 describe-network-interfaces
```

---

## 🎯 Outcome

- Fully working AWS infrastructure  
- EKS cluster ready for application deployment  
- Proper networking setup (public + private subnets)  
- IAM configured for Kubernetes workloads  
- Reusable Terraform structure  

---

## 👨‍💻

Ram Polarapu
