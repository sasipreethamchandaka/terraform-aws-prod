terraform {
  backend "s3" {
    bucket       = "terraform-state-aws-prod"
    key          = "env:/terraform.tfstate"
    region       = "eu-west-1"
    use_lockfile = true              # ← replaces dynamodb_table
  }
}
