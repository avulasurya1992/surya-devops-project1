variable "vpc_id" {
  type = string
}

variable "public_subnet_id" {
  type = string
}

variable "public_subnet_id_2" {
  type = string
}
variable "alb_sg_id" {
  type = string
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "target_group_arn" {
  type = string
}

