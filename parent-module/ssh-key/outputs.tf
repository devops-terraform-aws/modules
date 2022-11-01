output "get_key_name" {
  value = aws_key_pair.generated_key.key_name
}

output "private_key" {
  value = tls_private_key.private_key.private_key_pem
}