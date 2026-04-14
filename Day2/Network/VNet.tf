# Create Resource Group.

resource "azurerm_resource_group" "rg1" {
    name = "rg-01"
    location = "Central India"
}

#Virtual Network

resource "azurerm_virtual_network" "vnet"{
    name = "vnet-01"
    location = "Central India"
    resource_group_name = azurerm_resource_group.rg1.name
    address_space = ["10.0.0.0/16"]
}
