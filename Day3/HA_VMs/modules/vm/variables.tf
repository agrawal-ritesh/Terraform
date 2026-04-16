
variable "vm_count" {}
variable "vm_size" {}
variable "location" {}
variable "resource_group_name" {}
variable "subnet_id" {}
variable "admin_username" {}
variable "admin_password" {}
variable "tags" {
    type = map(string)
}