output "ip_address" {
  value       = aws_instance.instance.public_ip
  description = "The public IP address from the EC2 instance."
}

output "tags" {
  value = aws_instance.instance.tags
  description = "The Names of the EC2 instance"
}