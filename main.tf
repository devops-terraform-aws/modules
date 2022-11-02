module "jenkins" {

  source          = "./parent-module/ec2-instance"
  ami             = var.ami
  key_name        = module.aws_key.get_key_name
  instance_type   = var.instance_type
  name            = "jenkins-${var.name}"
  user_data       = file("${path.module}/scripts/jenkins.sh")
  security_groups = module.security_group.security_name
  region          = var.region
}

module "nexus" {

  source          = "./parent-module/ec2-instance"
  ami             = var.ami_nexus
  key_name        = module.aws_key.get_key_name
  instance_type   = var.instance_type
  security_groups = module.security_group.security_name
  name            = "nexus-${var.name}"
  user_data       = file("${path.module}/scripts/nexus.sh")
  region          = var.region
}

module "sonarqube" {

  source          = "./parent-module/ec2-instance"
  ami             = var.ami
  key_name        = module.aws_key.get_key_name
  instance_type   = var.instance_type
  security_groups = module.security_group.security_name
  name            = "sonar-${var.name}"
  user_data       = file("${path.module}/scripts/sonarqube.sh")
  region          = var.region
}

module "tomcat" {

  source = "./parent-module/ec2-instance"
  for_each = {
    for index, i in local.ec2_instance :
    i.name => i
  }
  ami             = var.ami
  key_name        = module.aws_key.get_key_name
  instance_type   = var.instance_type
  security_groups = module.security_group.security_name
  name            = "${each.value.name}-${var.name}"
  user_data       = templatefile("${path.module}/scripts/tomcat.sh.tftpl", { env = each.value.name })
  region          = var.region
}

module "aws_key" {

  source   = "./parent-module/ssh-key"
  key_name = var.key_name
}

resource "null_resource" "generated_key" {
  provisioner "local-exec" {
    command = <<-EOT
        echo '${module.aws_key.private_key}' > ./'${var.key_name}'.pem
        chmod 400 ./'${var.key_name}'.pem
      EOT
  }
}

module "security_group" {

  source      = "./parent-module/security-group"
  name        = local.name
  protocol    = var.protocol
  cidr_blocks = var.cidr_blocks
}