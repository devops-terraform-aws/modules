variable "ami" {
  type = string
}

variable "key_name" {
  type        = string
  description = "Enter the name of your key on aws"
}

variable "instance_type" {
  type = string
}

# variable "subnet_id" {
#   type        = string
#   description = "The subnet ID of your vpc"
# }

variable "region" {
  type = string
}

variable "name" {
  type = string
}

variable "cidr_blocks" {
  type = list(string)
}

variable "protocol" {
  type = string
}