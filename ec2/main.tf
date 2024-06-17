terraform {
    required_version = "~> 1.0"
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = "~> 5.0"
        }
    }
}

provider "aws" {
    region = "us-east-1"
}

resource "aws_instance" "ec2" {
    ami = "ami-04b70fa74e45c3917"
    instance_type = "t2.micro"
    user_data = ""

    tags = {
        Name = "FirstEC2"
        env = "prod"
    }
}

resource "aws_eip" "my_eip" {
    instance = aws_instance.test_ec2.id
}