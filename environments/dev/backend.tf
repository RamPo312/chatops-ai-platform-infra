terraform {
  backend "s3" {
    bucket         = "rampo3-chatops-tf-state"
    key            = "dev/eks/terraform.tfstate"
    region         = "us-east-2"
    dynamodb_table = "rampo3-chatops-tf-lock"
    encrypt        = true
  }
}
