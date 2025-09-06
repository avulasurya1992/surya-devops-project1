variable "vpc_cidr" {
  default = "10.1.0.0/16"
}
variable "public_subnet_cidr" {
  default = "10.1.1.0/24"
}
variable "private_subnet_cidr" {
  default = "10.1.2.0/24"
}
variable "az" {
  default = "us-east-1a"
}

variable "public_subnet_cidr_2" {
  default = "10.1.3.0/24"
}
variable "az2" {
  default = "us-east-1b"
}
