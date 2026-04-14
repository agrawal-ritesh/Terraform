# Creating Network Interface Card

variable "resource_group_name" {}
variable "location" {}
variable "subnet_id" {}
variable "nsg_id" {}

resource "azurerm_public_ip" "pip" {
  name                = "pip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
}

resource "azurerm_network_interface" "nic" {
  name                = "nic"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Static"
    public_ip_address_id          = azurerm_public_ip.pip.id
  }
}

resource "azurerm_network_interface_security_group_association" "assoc" {
  network_interface_id      = azurerm_network_interface.nic.id
  network_security_group_id = var.nsg_id
}

output "nic_id" {
  value = azurerm_network_interface.nic.id
}