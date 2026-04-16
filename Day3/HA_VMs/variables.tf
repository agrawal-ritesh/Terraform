
variable "location" {
    default = "East US"
}

variable "resource_group_name" {
    default = "rg-HA_VMs"
}

variable "admin_username" {}

variable "admin_password" {}

variable "vm_size" {
    default = "Standard_D2as_v5"
}

variable "tags" {
    type = map(stirng)  # This means the variable must be a map (key - value pair) where every value is s string.
}

variable "vm_count" {
    default = 5
}