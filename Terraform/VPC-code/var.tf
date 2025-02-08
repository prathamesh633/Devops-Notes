variable "vpc_cidr" {
  type = string
  default = "10.0.0.0/16"
  description = "vpc cidr"
}

variable "tag" {
  type = string
  default = "eg-tf"
}

variable "public_subnet_cidr" {
  default = ["10.0.1.0/24","10.0.2.0/24","10.0.4.0/24"]
}

variable "private_subnet_cidr" {
  default = ["10.0.3.0/24","10.0.8.0/24","10.0.11.0/24"]
}