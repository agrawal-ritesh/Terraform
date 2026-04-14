# Creating Network Security group

variable "resource_group_name" {}
variable "location" {}

resource "azurerm_network_security_group" "nsg" {
  name                = "nsg"
  location            = var.location
  resource_group_name = var.resource_group_name

  security_rule {
    name                       = "Allow-RDP"
    priority                   = 1000
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

output "nsg_id" {
  value = azurerm_network_security_group.nsg.id
}