# Creating Virtual Machine.

variable "resource_group_name" {}
variable "location" {}
variable "nic_id" {}
variable "admin_username" {}
variable "admin_password" {}

resource "azurerm_windows_virtual_machine" "vm" {
  name                = "vm-01-IND"
  location            = var.location
  resource_group_name = var.resource_group_name
  size                = "Standard_D2as_v5"

  admin_username = var.admin_username
  admin_password = var.admin_password

  network_interface_ids = [var.nic_id]

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