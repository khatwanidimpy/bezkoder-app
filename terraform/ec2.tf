data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
}

resource "aws_security_group" "alb" {
  name        = "alb-sg"
  description = "Allow HTTP from the internet"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
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
    Name = "alb-sg"
  }
}

resource "aws_security_group" "ec2" {
  name        = "ec2-sg"
  description = "Allow application traffic from ALB and SSH from the internet"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "App traffic from ALB"
    from_port   = var.http_port
    to_port     = var.http_port
    protocol    = "tcp"
    security_groups = [aws_security_group.alb.id]
  }

  ingress {
    description = "SSH"
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
    Name = "ec2-sg"
  }
}

resource "aws_instance" "app" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.public[0].id
  vpc_security_group_ids      = [aws_security_group.ec2.id]
  associate_public_ip_address = true

  user_data = <<-EOF
              #!/bin/bash
              apt update -y
              apt install -y docker.io awscli
              systemctl start docker
              systemctl enable docker

              # Login to ECR
              aws ecr get-login-password --region ${var.aws_region} | docker login --username AWS --password-stdin ${aws_ecr_repository.app.repository_url}

              # Pull the app
              docker pull ${aws_ecr_repository.app.repository_url}:latest

              # Run the app with DB env vars
              DB_HOST=$(echo ${aws_db_instance.postgres.endpoint} | cut -d: -f1)
              docker run -d -p ${var.http_port}:${var.http_port} \
                -e DB_HOST=$DB_HOST \
                -e DB_USER=${var.db_username} \
                -e DB_PASSWORD=${var.db_password} \
                -e DB_NAME=${var.db_name} \
                -e DB_PORT=5432 \
                ${aws_ecr_repository.app.repository_url}:latest
              EOF

  tags = {
    Name = "app-instance-ubuntu"
  }
}
