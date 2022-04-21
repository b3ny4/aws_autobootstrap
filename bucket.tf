
# S3 Bucket

resource "aws_kms_key" "terraform_state_key" {
  description = "Encrypts the terraform state for ${var.project_name}"
}

resource "aws_kms_alias" "terraform_state_alias" {
  name          = "alias/${var.project_name}-terraform-state-key"
  target_key_id = aws_kms_key.terraform_state_key.key_id
}

resource "aws_s3_bucket" "terraform_state" {
  bucket        = "${var.project_name}-terraform-state"
  force_destroy = true
}

resource "aws_s3_bucket_versioning" "terraform_state_versioning" {
  bucket = aws_s3_bucket.terraform_state.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "terraform_state_encryption" {
  bucket = aws_s3_bucket.terraform_state.id

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.terraform_state_key.arn
      sse_algorithm     = "aws:kms"
    }
  }
}

