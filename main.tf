module "jenkins" {
  count           = var.bootstrap ? 1 : 0
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
  count           = var.bootstrap ? 1 : 0
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
  count           = var.bootstrap ? 1 : 0
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
  count           = var.bootstrap ? 1 : 0
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

resource "null_resource" "generated_key" {
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

resource "null_resource" "ssh" {
  count = var.bootstrap ? 1 : 0
  provisioner "remote-exec" {
    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("${module.unique_name[0].unique}.pem")
      host        = module.jenkins[0].ip_address
    }

    inline = [
      "sleep 500",
      "sudo cat /var/lib/jenkins/secrets/initialAdminPassword > /tmp/jenkins_admin_password.txt"
    ]
  }
}

resource "null_resource" "copy_file" {
  count = var.bootstrap ? 1 : 0
  provisioner "local-exec" {
    command = "scp -o StrictHostKeyChecking=no -i ./'${module.unique_name[0].unique}'.pem ubuntu@${module.jenkins[0].ip_address}:/tmp/jenkins_admin_password.txt ${path.module}/jenkins_admin_password.txt"

  }

  provisioner "local-exec" {
    when    = destroy
    command = "rm ${path.module}/jenkins_admin_password.txt"
  }

  depends_on = [
    null_resource.generated_key, null_resource.ssh
  ]
}
