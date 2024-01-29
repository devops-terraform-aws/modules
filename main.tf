module "jenkins" {
  count           = var.bootstrap && var.bootstrap_jenkins ? 1 : 0
  source          = "./parent-module/ec2-instance"
  ami             = data.aws_ami.ubuntu-linux-2004.id
  key_name        = module.aws_key[0].get_key_name
  instance_type   = var.instance_type
  name            = "jenkins-${var.name}"
  user_data       = file("${path.module}/scripts/jenkins.sh")
  security_groups = module.security_group[0].security_name
  region          = var.region
}

module "nexus" {
  count           = var.bootstrap && var.bootstrap_nexus ? 1 : 0
  source          = "./parent-module/ec2-instance"
  ami             = data.aws_ami.redhat-linux.id
  key_name        = module.aws_key[0].get_key_name
  instance_type   = var.instance_type
  security_groups = module.security_group[0].security_name
  name            = "nexus-${var.name}"
  user_data       = file("${path.module}/scripts/nexus.sh")
  region          = var.region
}

module "sonarqube" {
  count           = var.bootstrap && var.bootstrap_sonarqube ? 1 : 0
  source          = "./parent-module/ec2-instance"
  ami             = data.aws_ami.ubuntu-linux-2004.id
  key_name        = module.aws_key[0].get_key_name
  instance_type   = var.instance_type
  security_groups = module.security_group[0].security_name
  name            = "sonar-${var.name}"
  user_data       = file("${path.module}/scripts/sonarqube.sh")
  region          = var.region
}

module "tomcat" {
  count           = var.bootstrap && var.bootstrap_tomcat ? 1 : 0
  source          = "./parent-module/ec2-instance"
  ami             = data.aws_ami.ubuntu-linux-2004.id
  key_name        = module.aws_key[0].get_key_name
  instance_type   = var.instance_type
  security_groups = module.security_group[0].security_name
  name            = var.name
  user_data       = file("${path.module}/scripts/tomcat.sh")
  region          = var.region
}

module "aws_key" {
  count    = var.bootstrap ? 1 : 0
  source   = "./parent-module/ssh-key"
  key_name = module.unique_name[0].unique
}

module "unique_name" {
  count  = var.bootstrap ? 1 : 0
  source = "./parent-module/random"
}

resource "terraform_data" "generated_key" {
  count = var.bootstrap ? 1 : 0
  provisioner "local-exec" {
    command = <<-EOT
        echo '${module.aws_key[0].private_key}' > ./'${module.unique_name[0].unique}'.pem
        chmod 400 ./'${module.unique_name[0].unique}'.pem
      EOT
  }
}

module "security_group" {
  count       = var.bootstrap ? 1 : 0
  source      = "./parent-module/security-group"
  name        = "${local.name}-${module.unique_name[0].unique}"
  cidr_blocks = ["${chomp(data.http.myip.response_body)}/32"]
}