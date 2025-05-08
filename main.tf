provider "aws" {
  region = "us-west-1"
}

data "aws_key_pair" "deployer" {
  key_name = "class_keypair2"
}

resource "aws_security_group" "minimal_sg" {
  name        = "minimal-sg"

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Use internal CIDR range in prod
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
}

resource "aws_instance" "frontend" {
  ami                    = "ami-08be293cd057c7a9d"
  instance_type          = "t2.micro"
  key_name               = data.aws_key_pair.deployer.key_name
  vpc_security_group_ids = [aws_security_group.minimal_sg.id]
  tags = {
    Name = "frontend"
  }
}

resource "aws_instance" "backend" {
  ami                    = aws_instance.frontend.ami
  instance_type          = "t2.micro"
  key_name               = data.aws_key_pair.deployer.key_name
  vpc_security_group_ids = [aws_security_group.minimal_sg.id]
  tags = {
    Name = "backend"
  }
}

resource "aws_instance" "database" {
  ami                    = aws_instance.frontend.ami
  instance_type          = "t2.micro"
  key_name               = data.aws_key_pair.deployer.key_name
  vpc_security_group_ids = [aws_security_group.minimal_sg.id]
  tags = {
    Name = "database"
  }
}

output "frontend_ip" {
  value = aws_instance.frontend.public_ip
}

output "backend_ip" {
  value = aws_instance.backend.public_ip
}

output "database_ip" {
  value = aws_instance.database.public_ip
}

output "database_private_ip" {
  value = aws_instance.database.private_ip
}
