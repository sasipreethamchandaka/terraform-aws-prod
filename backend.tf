terraform {
  backend "s3" {
    bucket         = "terraform-state-aws-prod"
    key            = "prod/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "use_lockfile"
  }
}
