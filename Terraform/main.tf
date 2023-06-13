terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region  = "us-west-2"
}

resource "aws_instance" "app_server" {
  # Ubuntu 22.04 LTS
  ami			= "ami-03f65b8614a860c29"
  instance_type = var.instance_flavor
  # Use SSH key already imported to account
  key_name   = var.ssh_key

  # Network settings
  vpc_security_group_ids = [var.security_group]
  subnet_id              = var.subnet

  tags = {
    Name = var.instance_name
  }
}