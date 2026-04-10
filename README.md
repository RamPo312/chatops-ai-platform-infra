# 🚀 ChatOps AI Platform – Terraform Infrastructure

## 📌 Overview

This repository contains Terraform code to provision and manage infrastructure for the **ChatOps AI Platform** on AWS.

It follows a structured approach:

* **Bootstrap layer** → Creates remote backend (S3 + DynamoDB)
* **Environment layer** → Deploys actual infrastructure (EKS, networking, etc.)

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

* Terraform ≥ 1.5
* AWS CLI configured
* IAM permissions for:

  * S3
  * DynamoDB
  * EKS
  * VPC

---

## 🔐 Important Notes

### ❌ Do NOT commit:

* `.terraform/`
* `terraform.tfstate`
* `terraform.tfvars`

These are ignored via `.gitignore`.

---

## 🧱 Step 1 — Bootstrap Backend (Run once)

This creates:

* S3 bucket (Terraform state)
* DynamoDB table (state locking)

```bash
cd bootstrap/backend-state

terraform init
terraform apply
```

---

## 🌍 Step 2 — Deploy Environment (Dev)

```bash
cd environments/dev

terraform init
terraform plan
terraform apply
```

---

## 🔁 Step 3 — Destroy Infrastructure

```bash
terraform destroy
```

---

## 🔧 Variables

Update values using:

```bash
cp terraform.tfvars.example terraform.tfvars
vim terraform.tfvars
```

---

## 🧠 Terraform Concepts Used

* Remote backend (S3)
* State locking (DynamoDB)
* Modular structure
* Environment-based deployment

---

## ⚠️ Best Practices

* Always run `terraform plan` before apply
* Never commit state files
* Use separate environments (dev, prod)
* Use versioned providers

---

## 🧹 Cleanup

To reset local Terraform state:

```bash
rm -rf .terraform
terraform init
```

---

## 👨‍💻 Author

Ram Polarapu
DevOps / Cloud Engineer

