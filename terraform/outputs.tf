output "ec2_public_ip" {
  value = aws_instance.app.public_ip
}

output "ec2_ssh_command" {
  value = "ssh -i ~/.ssh/id_rsa ubuntu@${aws_instance.app.public_ip}"
}

output "ecr_repository_url" {
  value = aws_ecr_repository.app.repository_url
}

output "vpc_id" {
  value = aws_vpc.main.id
}

output "public_subnet_ids" {
  value = aws_subnet.public[*].id
}
output "elastic_ip" {
  value = aws_eip.app_eip.public_ip
}