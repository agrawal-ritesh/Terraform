
variable "location" {
    default = "Central India"
}

variable "resource_group_name" {
    default = "rg-HA_VMs"
}

variable "admin_username" {}

variable "admin_password" {}

variable "vm_size" {
    default = "Standard_D2s_v3"
}

variable "tags" {
    type = map(string)  # This means the variable must be a map (key - value pair) where every value is s string.
}

variable "vm_count" {
    default = 5
}