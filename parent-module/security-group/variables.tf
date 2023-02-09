variable "name" {
  type        = string
  description = "The name to assign to the resource."
}

variable "cidr_blocks" {
  type        = list(string)
  description = "List of CIDR blocks."
}