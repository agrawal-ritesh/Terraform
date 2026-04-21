# Creating Network

#This means, we are calling the variabel from outside.
variable "resource_group_name" {}
variable "location" {}

# Network Block

resource "azurerm_virtual_network" "vnet" {
    name = "vnet01-IND"
    location = var.location
    resource_group_name = var.resource_group_name
    address_space = ["10.0.0.0/16"]
}

output "vnet_name" {
    value = azurerm_virtual_network.vnet.name
}