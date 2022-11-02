resource "aws_instance" "instance" {
  ami                         = var.ami
  key_name                    = var.key_name
  instance_type               = var.instance_type
  security_groups             = var.security_groups
  user_data                   = var.user_data
  associate_public_ip_address = true
  tags = {
    Name = var.name
  }

  # provisioner "remote-exec" {

  #   connection {
  #     type        = "ssh"
  #     user        = "ubuntu"
  #     private_key = file(var.key_name)
  #     host        = self.public_ip
  #   }

  #   inline = [
  #     "sudo cat /var/lib/jenkins/secrets/initialAdminPassword"
  #   ]
  # }
}
