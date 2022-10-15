locals {
  name = "tomcat-security-${var.name}"
}

locals {
  ec2_instance = [{
    name = "dev"
    },
    {
      name = "stage"
    },
    {
      name = "prod"
    }
  ]
}