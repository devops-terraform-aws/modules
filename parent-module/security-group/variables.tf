variable "name" {
  type        = string
  description = "The name to assign to the resource."
}

variable "cidr_blocks" {
  type        = list(string)
  description = "List of CIDR blocks."
}

variable "protocol" {
  type        = string
  description = "If you select a protocol of -1 (semantically equivalent to all, which is not a valid value here), you must specify a from_port and to_port equal to 0."
}