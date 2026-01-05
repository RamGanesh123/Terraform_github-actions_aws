variable "env" {}
variable "vpc_id" {}
variable "subnet_ids" {
  type = list(string)
}
variable "alb_sg_id" {}
variable "target_group_arn" {}
variable "instance_type" {}
