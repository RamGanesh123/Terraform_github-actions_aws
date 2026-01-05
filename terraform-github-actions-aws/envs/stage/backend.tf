terraform {
  backend "s3" {
    bucket         = "my-terraform-state-env-stage"
    key            = "stage/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks-stage"
    encrypt        = true
  }
}
