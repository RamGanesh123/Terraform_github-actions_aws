terraform {
  backend "s3" {
    bucket         = "my-terraform-state-env-dev"
    key            = "dev/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks-dev"

    encrypt        = true

    
  }
}
