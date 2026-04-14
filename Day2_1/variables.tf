# Creating Variable.

variable "resource_group_name" {
    default = "rg-test"
}

variable "location" {
    default = "Central India"
}

variable "admin_username" {
    default = "azureadmin"
}

variable "admin_password" {
    sensitive = true    # this will hide the password in output/logs
}