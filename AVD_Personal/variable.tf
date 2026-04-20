variable "location" {
    default = "East US"
}

variable "resource_group_name" {
    default = "rg-pd"
}

variable "admin_username" {}
variable "admin_password" {}

variable "tags" {
    type = map(string)
}