
variable "resource_group_name" {
    default = "avd-rg"
}

variable "location" {
    default = "US East"
}

variable "vm_count" {
    default = 3
}

variable "tags" {
    type = map(string)
}

variable "admin_username" {}

variable "admin_passowrd" {}

