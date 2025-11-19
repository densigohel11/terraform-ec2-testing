terraform {
  backend "s3" {
    bucket         = "demo-jenkins-test"
    key            = "ec2/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "Users"
    encrypt        = true
  }
}
