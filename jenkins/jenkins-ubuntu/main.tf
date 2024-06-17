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

resource "aws_instance" "jenkins-ubuntu" {
    ami = "ami-04b70fa74e45c3917"
    instance_type = "t2.medium"
    user_data = file("user_data.sh")
    key_name = "aws_dev"
    subnet_id = "subnet-0e7076b6787f61947"              # public subnet us-east-1a
    vpc_security_group_ids = ["sg-0939884e8c62e87e5"]  # FreeTPCAccessSG
    tags = {
        Name = "jenkins-ubuntu"
        env = "dev"
    }
}

resource "aws_eip" "my_eip" {
    instance = aws_instance.jenkins-ubuntu.id
}