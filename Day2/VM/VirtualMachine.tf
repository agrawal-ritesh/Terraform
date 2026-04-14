# Windows Virtual Machine

# Create Resource Group.

resource "azurerm_resource_group" "rg5" {
  name     = "rg-05"
  location = "Central India"
}

#Virtual Network

resource "azurerm_virtual_network" "vnet" {
  name                = "vnet-05"
  location            = "Central India"
  resource_group_name = azurerm_resource_group.rg5.name
  address_space       = ["10.0.0.0/16"]
}

#Subnets

resource "azurerm_subnet" "subnet" {
  name                 = "net-subnet"
  virtual_network_name = azurerm_virtual_network.vnet.name
  resource_group_name  = azurerm_resource_group.rg5.name
  address_prefixes     = ["10.0.0.0/24"]
}

#Public IP

resource "azurerm_public_ip" "pip" {
  name                = "pip-net"
  location            = azurerm_resource_group.rg5.location
  resource_group_name = azurerm_resource_group.rg5.name
  allocation_method   = "Static"
}


#Network Interface

resource "azurerm_network_interface" "nic" {
  name                = "nic-vm"
  location            = azurerm_resource_group.rg5.location
  resource_group_name = azurerm_resource_group.rg5.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.pip.id
  }

}

# Network Security Group

resource "azurerm_network_security_group" "nsg" {
  name                = "nsg-net"
  location            = azurerm_resource_group.rg5.location
  resource_group_name = azurerm_resource_group.rg5.name

  # To allow RDP

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

# Associate the NSG with NIC

resource "azurerm_network_interface_security_group_association" "nsg_assoc" {
  network_interface_id      = azurerm_network_interface.nic.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

resource "azurerm_windows_virtual_machine" "vm" {
  name                = "vm-01"
  location            = azurerm_resource_group.rg5.location
  resource_group_name = azurerm_resource_group.rg5.name
  size                = "Standard_D2as_v5"

  admin_username = "azureuser"
  admin_password = "Password1234!"   # ⚠️ Change this!

  network_interface_ids = [
    azurerm_network_interface.nic.id
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }
}