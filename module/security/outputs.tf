output "vpc_id" {
  value = aws_security_group.example.vpc_id
}

output "public_subnet_ids" {
  value = []  # If you don't have any dependencies on public subnets in your security module
}

output "private_subnet_ids" {
  value = []  # If you don't have any dependencies on private subnets in your security module
}
