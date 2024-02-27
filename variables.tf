variable "instance_type" {
  type        = string
  description = "Instance type to use for the instance. Updates to this field will trigger a stop/start of the EC2 instance."

  validation {
    condition     = var.instance_type != "t2.micro"
    error_message = "Instance size must be t2.small or higher."
  }
}

variable "region" {
  type        = string
  description = "Specify the region to for resources to be created."
}

variable "name" {
  type        = string
  description = "The name to assign to the resource."
}

variable "bootstrap" {
  type        = bool
  description = "Bootstrap all servers"
}

variable "bootstrap_jenkins" {
  type        = bool
  description = "Bootstrap Jenkins server"
}

variable "bootstrap_tomcat" {
  type        = bool
  description = "Bootstrap Tomcat server"
}

variable "bootstrap_nexus" {
  type        = bool
  description = "Bootstrap Nexus server"
}

variable "bootstrap_sonarqube" {
  type        = bool
  description = "Bootstrap SonarQube server"
}

variable "allow_all_network_traffic" {
  type        = bool
  description = "Set to `true` if you want to allow all network traffic to VM"
}