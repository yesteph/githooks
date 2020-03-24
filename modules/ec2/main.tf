provider "aws" {
  version = "2.54.0"
  region  = "eu-west-1"
}

variable "instance_type" {
  default     = "t2.micro"
  description = "Instance type as specified by the Cloud provider"
}

variable "name" {
  description = "Name of the EC2 instance"
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-trusty-14.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "demo" {
  instance_type = "var.instance_type"
  ami           = "data.aws_ami.ubuntu.id"
  tags = {
    Name = var.name
  }
}
