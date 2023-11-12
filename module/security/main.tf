provider "aws" {
  region = "us-east-1"  # Update with your desired region
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

resource "aws_security_group" "example" {
  name        = "example"
  description = "Allow inbound SSH and outbound HTTP traffic"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Add other security group rules as needed
}

output "vpc_id" {
  value = var.vpc_id
}
