data "aws_ami" "ubuntu-linux-2004" {
  most_recent = true
  owners      = ["099720109477"] # Canonical
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

data "aws_ami" "redhat-linux" {
  most_recent = true

  filter {
    name   = "name"
    values = ["RHEL-8.6.0_HVM-20220503-x86_64-*"]
  }
}

data "http" "myip" {
  url = "http://ipv4.icanhazip.com"
}