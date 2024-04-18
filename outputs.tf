output "jenkins_ssh" {
  value = var.bootstrap && var.bootstrap_jenkins ? "ssh -o StrictHostKeyChecking=no -i '${module.unique_name[0].unique}.pem' ubuntu@${module.jenkins[0].ip_address}" : null
}

output "jenkins_browser" {
  value = var.bootstrap && var.bootstrap_jenkins ? "${module.jenkins[0].ip_address}:8080" : null
}

output "nexus_ssh" {
  value = var.bootstrap && var.bootstrap_nexus ? "ssh  -o StrictHostKeyChecking=no-i '${module.unique_name[0].unique}.pem' ec2-user@${module.nexus[0].ip_address}" : null
}

output "nexus_browser" {
  value = var.bootstrap && var.bootstrap_nexus ? "${module.nexus[0].ip_address}:8081" : null
}

output "sonarqube_ssh" {
  value = var.bootstrap && var.bootstrap_sonarqube ? "ssh -o StrictHostKeyChecking=no -i '${module.unique_name[0].unique}.pem' ubuntu@${module.sonarqube[0].ip_address}" : null
}

output "sonarqube_browser" {
  value = var.bootstrap && var.bootstrap_sonarqube ? "${module.sonarqube[0].ip_address}:9000" : null
}

output "tomcat_browser" {
  value = var.bootstrap && var.bootstrap_tomcat ? "${module.tomcat[0].ip_address}:8080" : null
}

output "tomcat_ssh" {
  value = var.bootstrap && var.bootstrap_tomcat ? "ssh -o StrictHostKeyChecking=no -i '${module.unique_name[0].unique}.pem' ubuntu@${module.tomcat[0].ip_address}" : null
}


