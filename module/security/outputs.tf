output "security_group_id" {
  value = var.create_security_group ? aws_security_group.examples[0].id : null
}
