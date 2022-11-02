output "security_name" {
  value       = aws_security_group.security_group.*.name
  description = "The security group name"
}