resource "aws_instance" "instance" {
  ami                         = var.ami
  key_name                    = var.key_name
  instance_type               = var.instance_type
  vpc_security_group_ids      = var.vpc_security_group_ids
  subnet_id                   = var.subnet_id
  user_data                   = var.user_data
  associate_public_ip_address = true
  tags = {
    Name = var.name
  }
}