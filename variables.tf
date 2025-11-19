variable "region" {
  description = "AWS Region"
  default     = "us-east-1"
}

variable "instance_ami" {
  description = "AMI to use for EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "instance_name" {
  description = "Tag name for instance"
  type = string
}
