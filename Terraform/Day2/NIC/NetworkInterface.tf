# Create Resource Group.

resource "azurerm_resource_group" "rg3" {
    name = "rg-03"
    location = "Central India"
}

#Virtual Network

resource "azurerm_virtual_network" "vnet"{
    name = "vnet-03"
    location = "Central India"
    resource_group_name = azurerm_resource_group.rg3.name
    address_space = ["10.0.0.0/16"]
}

#Subnets

resource "azurerm_subnet" "subnet"{
    name = "net-subnet"
    virtual_network_name = azurerm_virtual_network.vnet.name
    resource_group_name = azurerm_resource_group.rg3.name
    address_prefixes = ["10.0.0.0/24"]
}

#Public IP

resource "azurerm_public_ip" "pip" {
    name = "pip-net"
    location = azurerm_resource_group.rg3.location
    resource_group_name = azurerm_resource_group.rg3.name
    allocation_method = "Static"
}


#Network Interface

resource "azurerm_network_interface" "nic"{
    name = "nic-vm"
    location = azurerm_resource_group.rg3.location
    resource_group_name = azurerm_resource_group.rg3.name

  ip_configuration {
    name = "internal"
    subnet_id = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.pip.id
  }
  
}