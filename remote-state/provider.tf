terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.66.0"
    }
  }
  backend "s3"{
      bucket = "devops81s-remote-state"
      key = "remote-state-demo" 
      #every repo should have unique state file key otherwise everything is placed here
      region= "us-east-1"
      dynamodb_table= "81s-locking"
  }

}

provider "aws" {
  # Configuration options
  region= "us-east-1"
}