terraform{
  required_providers{
    aws = {
      source = "hashicorp/aws"
    }
  }
}

provider "aws"{
  region = "ap-south-1"
}

resource "aws_instance" "web_server"{
  ami = "ami-0011550b539717e2a"
  instance_type = "t3.micro"
  key_name = "lunaria-key-pair"
  vpc_security_group_ids = [aws_security_group.ssh_access.id]
}

resource "aws_security_group" "ssh_access"{
  name = "lunaria-ssh-sg"
  description = "Allow SSH access from my IP"

  ingress{
    description ="SSH"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = [var.my_ip]
  }

  egress{
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks =["0.0.0.0/0"]
  }
}

