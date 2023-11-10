provider "aws" {
  region = "eu-west-1" # Set your desired AWS region
}

resource "aws_dynamodb_table" "courses" {
  name           = "dev-courses"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key = "Course URL"

  attribute {
    name = "Course URL"
    type = "S"
  }

}
