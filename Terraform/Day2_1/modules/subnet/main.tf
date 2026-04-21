#Creating Subnet

variable "resource_group_name" {}
variable "location" {}
variable "vnet_name" {}

resource "azurerm_subnet" "subnet" {
    name = "subnet-IND"
    resource_group_name = var.resource_group_name
    virtual_network_name = var.vnet_name  # The network gets created. The output from network module goes to root module, and from root module, the variable comes here.
    address_prefixes = ["10.0.0.0/24"]
}

output "subnet_id" {
    value = azurerm_subnet.subnet.id
}

