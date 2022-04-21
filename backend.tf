
# New backend configuration

locals {
  backend_config = <<-EOT
    terraform {
      backend "s3" {
        bucket = "${aws_s3_bucket.terraform_state.bucket}"
        key = "tf-infra/terraform.tfstate"
        region = "${var.region}"
        dynamodb_table = "${aws_dynamodb_table.terraform_locks.name}"
        encrypt = true
      }
    }
  EOT
}

resource "local_file" "backend_config_file" {
  content  = local.backend_config
  filename = "${path.module}/../backend.tf"
}
