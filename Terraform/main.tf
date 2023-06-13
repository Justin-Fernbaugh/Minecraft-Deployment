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

resource "aws_security_group" "minecraft_sg" {
  name        = "minecraft_sg"
  description = "Allow inbound traffic on port 25565 and SSH on port 22"

  ingress {
    from_port   = 25565
    to_port     = 25565
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "minecraft_sg"
  }
}

resource "aws_key_pair" "deployer" {
  key_name   = var.ssh_key_name
  public_key = var.ssh_public_key
}

resource "aws_instance" "app_server" {
  # Ubuntu 22.04 LTS
  ami			= "ami-03f65b8614a860c29"
  instance_type = var.instance_flavor
  # Assign SSH key from resource above
  key_name      = aws_key_pair.deployer.key_name

  # Network settings
  vpc_security_group_ids = [aws_security_group.minecraft_sg.id]

  tags = {
    Name = var.instance_name
  }
}