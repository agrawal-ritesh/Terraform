# Create Resource Group.

resource "azurerm_resource_group" "rg2" {
    name = "rg-02"
    location = "Central India"
}

#Virtual Network

resource "azurerm_virtual_network" "vnet"{
    name = "vnet-02"
    location = "Central India"
    resource_group_name = azurerm_resource_group.rg2.name
    address_space = ["10.0.0.0/16"]
}

#Subnets

resource "azurerm_subnet" "subnet"{
    name = "net-subnet"
    virtual_network_name = azurerm_virtual_network.vnet.name
    resource_group_name = azurerm_resource_group.rg2.name
    address_prefixes = ["10.0.0.0/24"]
}

#Public IP

resource "azurerm_public_ip" "pip" {
    name = "pip-net"
    location = azurerm_resource_group.rg2.location
    resource_group_name = azurerm_resource_group.rg2.name
    allocation_method = "Static"
}
