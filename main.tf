module "jenkins" {
  source          = "git::https://github.com/devops-terraform-aws/ec2-instance-module.git?ref=v1.0.0"
  count           = var.bootstrap && var.bootstrap_jenkins ? 1 : 0
  ami             = data.aws_ami.ubuntu-linux-2004.id
  key_name        = module.aws_key[0].get_key_name
  instance_type   = var.instance_type
  name            = "jenkins-${var.name}"
  user_data       = file("${path.module}/scripts/jenkins.sh")
  security_groups = module.security_group[0].security_name
  region          = var.region
}

module "nexus" {
  source          = "git::https://github.com/devops-terraform-aws/ec2-instance-module.git?ref=v1.0.0"
  count           = var.bootstrap && var.bootstrap_nexus ? 1 : 0
  ami             = data.aws_ami.redhat-linux.id
  key_name        = module.aws_key[0].get_key_name
  instance_type   = var.instance_type
  security_groups = module.security_group[0].security_name
  name            = "nexus-${var.name}"
  user_data       = file("${path.module}/scripts/nexus.sh")
  region          = var.region
}

module "sonarqube" {
  source          = "git::https://github.com/devops-terraform-aws/ec2-instance-module.git?ref=v1.0.0"
  count           = var.bootstrap && var.bootstrap_sonarqube ? 1 : 0
  ami             = data.aws_ami.ubuntu-linux-2004.id
  key_name        = module.aws_key[0].get_key_name
  instance_type   = var.instance_type
  security_groups = module.security_group[0].security_name
  name            = "sonar-${var.name}"
  user_data       = file("${path.module}/scripts/sonarqube.sh")
  region          = var.region
}

module "tomcat" {
  source          = "git::https://github.com/devops-terraform-aws/ec2-instance-module.git?ref=v1.0.0"
  count           = var.bootstrap && var.bootstrap_tomcat ? 1 : 0
  ami             = data.aws_ami.ubuntu-linux-2004.id
  key_name        = module.aws_key[0].get_key_name
  instance_type   = var.instance_type
  security_groups = module.security_group[0].security_name
  name            = var.name
  user_data       = file("${path.module}/scripts/tomcat.sh")
  region          = var.region
}

module "aws_key" {
  source   = "git::https://github.com/devops-terraform-aws/ssh-key-module.git?ref=v1.0.0"
  count    = var.bootstrap ? 1 : 0
  key_name = module.unique_name[0].unique
}

module "unique_name" {
  source = "git::https://github.com/devops-terraform-aws/random-module.git?ref=v1.0.0"
  count  = var.bootstrap ? 1 : 0
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
  source      = "git::https://github.com/devops-terraform-aws/security-group-module.git?ref=v1.0.0"
  count       = var.bootstrap ? 1 : 0
  name        = "${local.name}-${module.unique_name[0].unique}"
  cidr_blocks = ["${chomp(data.http.myip.response_body)}/32"]
}