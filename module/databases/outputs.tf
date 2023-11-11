# outputs.tf

output "db_instance_address" {
  value = aws_db_instance.default.endpoint
}

output "db_instance_username" {
  value = aws_db_instance.default.username
}
