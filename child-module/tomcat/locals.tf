locals {
  name = "tomcat-security-${var.name}"
}

locals {
  ec2_instance = [{
    name = "dev"
    },
    {
      name = "qa"
    },
    {
      name = "uat"
    },
    {
      name = "prod"
    }
  ]
}