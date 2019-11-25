variable "aws_region" { default = "us-east-1" }
variable "project_name" { default = "clearscale-andrews" }

variable "docker_image" {
  default = "latest"
}

variable "vpc_cidr_block" {
  default = "10.1.0.0/16"
}

variable "public_subnets" {
  default = ["10.1.0.0/24", "10.1.1.0/24", "10.1.2.0/24"]
}

variable "private_subnets" {
  default = ["10.1.100.0/24", "10.1.101.0/24", "10.1.102.0/24"]
}
