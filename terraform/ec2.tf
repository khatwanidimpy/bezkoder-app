resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  public_key = file("~/.ssh/id_rsa.pub")  
}

resource "aws_security_group" "ec2" {
  name        = "ec2-sg"
  description = "Allow SSH and app traffic"
  vpc_id      = aws_vpc.main.id

  # SSH access
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  
  }

  # App port (match your container)
  ingress {
    description = "App"
    from_port   = var.http_port
    to_port     = var.http_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Outbound
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ec2-sg"
  }
}


resource "aws_instance" "app" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.public[0].id
  vpc_security_group_ids      = [aws_security_group.ec2.id]
  associate_public_ip_address = true

  key_name = aws_key_pair.deployer.key_name  
  user_data = <<-EOF
              #!/bin/bash
              set -e

              apt update -y
              apt install -y docker.io awscli

              systemctl start docker
              systemctl enable docker

              usermod -aG docker ubuntu

              # Create app directory
              mkdir -p /home/ubuntu/app
              chown ubuntu:ubuntu /home/ubuntu/app
              EOF

  tags = {
    Name = "bezkoder-ec2"
  }
}


output "ec2_public_ip" {
  value = aws_instance.app.public_ip
}

output "ec2_ssh_command" {
  value = "ssh -i ~/.ssh/id_rsa ubuntu@${aws_instance.app.public_ip}"
}
