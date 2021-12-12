terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }
}

provider "aws" {
  profile = "default"
  region  = "us-east-1"
}

resource "aws_sqs_queue" "sqs-test" {
  name                        = "sqs-test.fifo"
  fifo_queue                  = true
  content_based_deduplication = true
}

resource "aws_sns_topic" "sns-test" {
  name                        = "sns-test.fifo"
  fifo_topic                  = true
  content_based_deduplication = true
}
