resource "aws_security_group" "examples" {
  name        = "examples"
  description = "Allow inbound SSH and outbound HTTP traffic"
  vpc_id      = var.vpc_id

  count = var.create_security_group ? 1 : 0  # Only create the security group if the variable is true

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Create a separate security group rule for RDS
  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

output "security_group_id" {
  value = aws_security_group.examples[0].id
}
