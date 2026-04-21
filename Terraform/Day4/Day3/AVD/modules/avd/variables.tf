variable "resource_group_name" {}

variable "location" {}
   
variable "vm_count" {}

variable "admin_username" {}

variable "admin_password" {}

variable "tags" {
    type = map(string)
}
