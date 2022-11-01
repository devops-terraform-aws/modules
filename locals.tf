locals {
  name = "security-${var.name}"
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