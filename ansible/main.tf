provider "aws" {
    region = "us-east-1"
}

resource "aws_instance" "ans" {
    ami = data.aws_ami.ubuntu_ami.id #"ami-09040d770ffe2224f"
    instance_type = "t2.micro"
    subnet_id = "subnet-0e7076b6787f61947"
    associate_public_ip_address = true
    key_name = "aws_dev"
    security_groups = ["sg-0895b0867d5f3af4f"]
    tags = {
        Name = "ansible"
    }

    # Add a user data script
      user_data = <<-EOF
                  #!/bin/bash
                  sudo useradd ansible
                  echo "ansible:password" | sudo chpasswd
                  echo "ansible ALL=(ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/ansible
                  sudo apt update
                  sudo apt install -y python3 python3-pip sshpass
                  sudo -i -u ansible bash << 'EOF2'
                  pip3 install --user ansible
                  EOF2
                  sudo mkdir /etc/ansible
                  sudo chown -R ansible:ansible /etc/ansible/
                  EOF
}
