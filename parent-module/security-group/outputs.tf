output "security_id" {
  value = aws_security_group.security_group.*.id
  description = "The security group id."
}