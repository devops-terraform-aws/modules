output "ssh" {
  value = "ssh -i 'EC2.pem' ubuntu@${module.jenkins.ip_address}"
}

output "open_browser" {
  value = "${module.jenkins.ip_address}:8080"
}