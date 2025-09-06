variable "private_subnet_ids" {
  type = list(string)
}

variable "app_sg_id" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "db_engine" {
  default = "mysql"
}

variable "db_version" {
  default = "8.0"
}

variable "db_instance_class" {
  default = "db.t3.micro"
}

variable "db_username" {
  default = "admin"
}

variable "db_password" {
  default = "ChangeMe123!" # should be stored in Secrets Manager
}

variable "db_port" {
  default = 3306
}

variable "project_name" {
  type = string
}

