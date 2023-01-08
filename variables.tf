variable "key_name" {
  type        = string
  description = "Key name of the Key Pair to use for the instance."
}

variable "instance_type" {
  type        = string
  description = "Instance type to use for the instance. Updates to this field will trigger a stop/start of the EC2 instance."
}

variable "region" {
  type        = string
  description = "Specify the region to for resources to be created."
}

variable "name" {
  type        = string
  description = "The name to assign to the resource."
}

variable "cidr_blocks" {
  type        = list(string)
  description = "The IPv4 CIDR block for the VPC"
}

variable "protocol" {
  type        = string
  description = "If you select a protocol of -1 (semantically equivalent to all, which is not a valid value here), you must specify a from_port and to_port equal to 0"
}