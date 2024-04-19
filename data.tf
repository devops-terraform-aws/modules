data "aws_ami" "ubuntu-linux-22" {
  most_recent = true
  owners      = ["099720109477"]
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-*-22.04-amd64-server-*"]
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
    values = ["RHEL-9*-x86_64-*"]
  }
}


data "http" "myip" {
  url = "http://ipv4.icanhazip.com"
}