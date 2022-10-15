variable "ami" {
  type = string
}

variable "key_name" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "subnet_id" {
  type = string
}

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

variable "from_port" {
  type = number
}

variable "to_port" {
  type = number
}