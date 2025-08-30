variable "public_subnet_id" { type = string }
variable "alb_sg_id" { type = string }
variable "target_group_arn" { type = string }
variable "tags" { type = map(string), default = {} }
