# AWS Ccredential
variable "access_key" {}

variable "secret_key" {}

# VPC
variable "vpc_name" {}

variable "vpc_cidr" {}

variable "ssh_public_key" {}

# Allow SSH IP
variable "allow_ssh_ip" {}

variable "desired_ondemand_capacity" {}
variable "autoscale_max_size" {}
variable "autoscale_desired_capasity" {}
