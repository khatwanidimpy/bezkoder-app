variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "ap-south-1"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for public subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_cidrs" {
  description = "CIDR blocks for private subnets"
  type        = list(string)
  default     = ["10.0.3.0/24", "10.0.4.0/24"]
}

variable "availability_zones" {
  description = "Availability zones"
  type        = list(string)
  default     = ["ap-south-1a", "ap-south-1b"]
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "ecr_repo_name" {
  description = "ECR repository name"
  type        = string
  default     = "bezkoder-app"
}

variable "http_port" {
  description = "Application port on EC2"
  type        = number
  default     = 8080
}

variable "alb_port" {
  description = "Load balancer listener port"
  type        = number
  default     = 80
}

variable "db_instance_class" {
  description = "RDS instance class"
  type        = string
  default     = "db.t3.micro"
}

variable "db_engine" {
  description = "Database engine"
  type        = string
  default     = "postgres"
}

variable "db_engine_version" {
  description = "Database engine version"
  type        = string
  default     = "15"
}

variable "db_allocated_storage" {
  description = "Allocated storage for DB (GB)"
  type        = number
  default     = 20
}

variable "db_name" {
  description = "Database name"
  type        = string
  default     = "bezkoder_db"
}

variable "db_username" {
  description = "Database username"
  type        = string
  default     = "postgres"
}

variable "db_password" {
  description = "Database password"
  type        = string
  default     = "db-app-node-11" 
}
