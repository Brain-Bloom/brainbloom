terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "eu-west-1" # Set your desired AWS region
}


resource "aws_s3_bucket" "courses_bucket" {
  bucket = "s3_bucket_courses_master_projet"
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

resource "aws_s3_bucket" "user_bucket" {
  bucket = "s3_bucket_cours_master_projet"
}

resource "aws_dynamodb_table" "users" {
  name           = "dev-users"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key = "user_email"

  attribute {
    name = "user_email"
    type = "S"
  }
}


