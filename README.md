# AWS Autobootstrap

A Terraform module that automatically provisions and configures an aws backend

## Example

An example worktree using the module:
```
.
├── aws_autobootstrap
│   ├── backend.tf
│   ├── bucket.tf
│   ├── dynamodb.tf
│   ├── LICENCE
│   ├── main.tf
│   ├── README.md
│   └── variables.tf
└── main.tf
```

main.tf
```HCL
# Set up Terraform
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

# provision and configure AWS backend
module "aws_autobootstrap" {
  source       = "./aws_autobootstrap"
  project_name = "example.com"
  region       = "eu-central-1"
}
```

You have to init Terraform twice. The first time you will initialize the local backend. After the module provisioned and configured the remote backend, terraform will ask you to init again.
```
terraform init
terraform apply
terraform init
```
