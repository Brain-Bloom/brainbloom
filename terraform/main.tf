provider "aws" {
  region = "eu-west-1" # Set your desired AWS region
  access_key = var.access_key
  secret_key = var.secret_key
}

resource "aws_dynamodb_table" "courses" {
  name           = "dev-courses"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key = "course_url"

  attribute {
    name = "course_url"
    type = "S"
  }

}
