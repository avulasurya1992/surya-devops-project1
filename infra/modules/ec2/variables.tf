variable "app_sg_id" {
description = "Security Group ID for application instances (ingress from ALB)"
type = string
}


variable "instance_type" {
description = "EC2 instance type"
type = string
default = "t3.micro"
}


variable "key_name" {
description = "Optional key pair name for SSH"
type = string
default = null
}


variable "app_port" {
description = "Application port exposed by instances"
type = number
default = 80
}


variable "tags" {
type = map(string)
default = {}
}
