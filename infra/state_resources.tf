provider "aws" {
  region = var.region
}

resource "aws_s3_bucket" "tf_state" {
  bucket = "my-unique-terraform-state-bucket-2025"
  acl    = "private"

  versioning {
    enabled = true
  }
}

resource "aws_dynamodb_table" "tf_lock" {
  name         = "terraform-lock-table"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}
