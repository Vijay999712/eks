terraform {
  backend "s3" {
    bucket         = "vj-state-bucket-harness"
    key            = "eks-cluster/terraform.tfstate"
    region         = "eu-north-1"
    dynamodb_table = "terraform-lock-table"
    encrypt        = true
  }
}
