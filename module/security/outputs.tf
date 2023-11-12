
output "security_group_id" {
  value = length(aws_security_group.examples) > 0 ? aws_security_group.examples[0].id : null
}
output "security_group_id" {
  value = aws_security_group.examples.id
}