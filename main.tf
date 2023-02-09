module "jenkins" {
  source          = "./parent-module/ec2-instance"
  ami             = data.aws_ami.ubuntu-linux-2004.id
  key_name        = module.aws_key.get_key_name
  instance_type   = var.instance_type
  name            = "jenkins-${var.name}"
  user_data       = file("${path.module}/scripts/jenkins.sh")
  security_groups = module.security_group.security_name
  region          = var.region
}

module "nexus" {
  source          = "./parent-module/ec2-instance"
  ami             = data.aws_ami.redhat-linux.id
  key_name        = module.aws_key.get_key_name
  instance_type   = var.instance_type
  security_groups = module.security_group.security_name
  name            = "nexus-${var.name}"
  user_data       = file("${path.module}/scripts/nexus.sh")
  region          = var.region
}

module "sonarqube" {
  source          = "./parent-module/ec2-instance"
  ami             = data.aws_ami.ubuntu-linux-2004.id
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
  ami             = data.aws_ami.ubuntu-linux-2004.id
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

module "unique_name" {
  source = "./parent-module/random"
}

resource "null_resource" "generated_key" {
  provisioner "local-exec" {
    command = <<-EOT
        echo '${module.aws_key.private_key}' > ./'${var.key_name}'-'${module.unique_name.unique}'.pem
        chmod 400 ./'${var.key_name}'-'${module.unique_name.unique}'.pem
      EOT
  }
}

module "security_group" {
  source      = "./parent-module/security-group"
  name        = "${local.name}-${module.unique_name.unique}"
  cidr_blocks = ["${chomp(data.http.myip.response_body)}/32"]
}

resource "null_resource" "ssh" {
  provisioner "remote-exec" {
    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("${var.key_name}-${module.unique_name.unique}.pem")
      host        = module.jenkins.ip_address
    }

    inline = [
      "sleep 300",
      "sudo cat /var/lib/jenkins/secrets/initialAdminPassword"
    ]
  }

}