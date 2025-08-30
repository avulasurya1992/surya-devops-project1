variable "vpc_id" { type = string }
variable "private_subnet_id" { type = string }
variable "launch_template_id" { type = string }


variable "app_port" { type = number, default = 8080 }
variable "health_check_path" { type = string, default = "/" }


variable "desired_capacity" { type = number, default = 1 }
variable "min_size" { type = number, default = 1 }
variable "max_size" { type = number, default = 2 }


variable "tags" { type = map(string), default = {} }
