variable "region" {}
variable "env" {}
variable "vpc_cidr" {}
variable "public_subnets" {
  type = list(string)
}
variable "azs" {
  type = list(string)
}
variable "instance_type" {}
