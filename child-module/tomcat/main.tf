module "tomcat" {

  source = "../../parent-module/ec2-instance"
  for_each = {
    for index, i in local.ec2_instance :
    i.name => i
  }
  ami                    = var.ami
  key_name               = var.key_name
  instance_type          = var.instance_type
  vpc_security_group_ids = module.security_group.security_id
  name                   = "${each.value.name}-${var.name}"
  user_data              = templatefile("${path.module}/tomcat.sh.tftpl", { env = each.value.name })
  subnet_id              = var.subnet_id
  region                 = var.region
}

module "security_group" {

  source = "../../parent-module/security-group"
  name   = local.name
  from_port   = var.from_port
  to_port     = var.to_port
  protocol    = var.protocol
  cidr_blocks = var.cidr_blocks
}