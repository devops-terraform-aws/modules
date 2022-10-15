output "ssh" {
  value = "ssh -i 'EC2.pem' ubuntu@${module.sonarqube.ip_address}"
}

output "open_browser" {
  value = "${module.sonarqube.ip_address}:9000"
}