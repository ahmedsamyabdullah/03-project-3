terraform {
  backend "s3" {
    bucket = "samy-main-bucket"
    key = "global/s3/terraform.tfstate"
    region = "us-east-1"
    dynamodb_table = "main_dynamodb"
    encrypt = true 
  }
}