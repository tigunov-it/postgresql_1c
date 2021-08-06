provider "aws" {
  region = "eu-north-1"
  }

data "aws_ami" "latest_ubuntu" { //Динамически получаем ami последней версии ubuntu
  owners = ["099720109477"]
  most_recent = true
  filter {
    name = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
}

resource "aws_spot_instance_request" "aws_spot" {
  ami = data.aws_ami.latest_ubuntu.id
  instance_type = "t3.xlarge"
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]
  user_data = file("bashscript.sh")
  key_name = "aws_stockholm"
    tags = {
     "Name" = "aws_spot"
   }
}

resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow ssh inbound traffic"
  # vpc_id      = aws_vpc.main.id

  ingress {
    description      = "ssh"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    # ipv6_cidr_blocks = [aws_vpc.main.ipv6_cidr_block]
  }

  ingress {
    description      = "postgres"
    from_port        = 5432
    to_port          = 5432
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    # ipv6_cidr_blocks = [aws_vpc.main.ipv6_cidr_block]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_ssh"
  }
}