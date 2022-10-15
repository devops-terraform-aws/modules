output "ssh" {
  value = "ssh -i 'EC2.pem' ec2-user@${module.nexus.ip_address}"
}

output "open_browser" {
  value = "${module.nexus.ip_address}:8081"
}