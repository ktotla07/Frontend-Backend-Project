terraform {
  backend "s3" {
    bucket         = "devops-backend-tf-state-732822664432"
    key            = "aws/dev/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}