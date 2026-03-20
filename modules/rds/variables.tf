variable "db_name" {
  type    = string
  default = "mydb"
}

variable "db_username" {
  type    = string
  default = "admin"
}

variable "db_password" {
  type    = string
  default = "admin123"
}

variable "instance_class" {
  type    = string
  default = "db.t3.micro"
}
