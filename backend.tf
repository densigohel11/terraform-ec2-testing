terraform {
  backend "s3" {
    bucket         = "demo-jenkins-test"
    key            = "ec2/terraform.tfstate"
    region         = "us-east-1"
    use_lockfile = "Users"
    encrypt        = true
  }
}
