output "jenkins_ssh" {
  value = "ssh -i '${var.key_name}.pem' ubuntu@${module.jenkins.ip_address}"
}

output "jenkins_browser" {
  value = "${module.jenkins.ip_address}:8080"
}

output "nexus_ssh" {
  value = "ssh -i '${var.key_name}.pem' ec2-user@${module.nexus.ip_address}"
}

output "nexus_browser" {
  value = "${module.nexus.ip_address}:8081"
}

output "sonarqube_ssh" {
  value = "ssh -i '${var.key_name}.pem' ubuntu@${module.sonarqube.ip_address}"
}

output "sonarqube_browser" {
  value = "${module.sonarqube.ip_address}:9000"
}

output "tomcat_servers" {
  value = values(module.tomcat)
}