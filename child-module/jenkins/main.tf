module "jenkins" {

  source                 = "../../parent-module/ec2-instance"
  ami                    = var.ami
  key_name               = var.key_name
  instance_type          = var.instance_type
  vpc_security_group_ids = module.security_group.security_id
  name                   = "jenkins-${var.name}"
  user_data              = file("${path.module}/jenkins.sh")
  subnet_id              = var.subnet_id
  region                 = var.region
}

module "security_group" {

  source      = "../../parent-module/security-group"
  name        = local.name
  from_port   = var.from_port
  to_port     = var.to_port
  protocol    = var.protocol
  cidr_blocks = var.cidr_blocks
}