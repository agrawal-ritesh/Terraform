# Resource Group
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
  tags     = var.tags
}

# Network
resource "azurerm_virtual_network" "vnet" {
  name                = "avd-vnet"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "subnet" {
  name                 = "avd-subnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.0.0/24"]
}

# Host Pool (PERSONAL)
resource "azurerm_virtual_desktop_host_pool" "hp" {
  name                = "personal-hostpool"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name

  type               = "Personal"
  load_balancer_type = "Persistent"

  tags = var.tags
}

# Registration Token
resource "azurerm_virtual_desktop_host_pool_registration_info" "reg" {
  hostpool_id     = azurerm_virtual_desktop_host_pool.hp.id
  expiration_date = timeadd(timestamp(), "24h")
}

# Workspace
resource "azurerm_virtual_desktop_workspace" "ws" {
  name                = "personal-workspace"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
}

# App Group
resource "azurerm_virtual_desktop_application_group" "dag" {
  name                = "personal-dag"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name

  type         = "Desktop"
  host_pool_id = azurerm_virtual_desktop_host_pool.hp.id
}

# Association
resource "azurerm_virtual_desktop_workspace_application_group_association" "assoc" {
  workspace_id         = azurerm_virtual_desktop_workspace.ws.id
  application_group_id = azurerm_virtual_desktop_application_group.dag.id
}

# NIC
resource "azurerm_network_interface" "nic" {
  name                = "personal-nic"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

# VM
resource "azurerm_windows_virtual_machine" "vm" {
  name                = "personal-avd-vm"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  size                = "Standard_D2as_v5"

  admin_username = var.admin_username
  admin_password = var.admin_password

  network_interface_ids = [
    azurerm_network_interface.nic.id
  ]

  zone = "1"

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsDesktop"
    offer     = "windows-11"
    sku       = "win11-21h2-avd"
    version   = "latest"
  }

  tags = var.tags
}

/*
# Need DNS
# AVD Agent (Register VM)
resource "azurerm_virtual_machine_extension" "avd_agent" {
  name                 = "avd-agent"
  virtual_machine_id   = azurerm_windows_virtual_machine.vm.id
  publisher            = "Microsoft.Powershell"
  type                 = "DSC"
  type_handler_version = "2.73"

  settings = <<SETTINGS
{
  "modulesUrl": "https://wvdportalstorageblob.blob.core.windows.net/galleryartifacts/Configuration_1.0.02714.342.zip",
  "configurationFunction": "Configuration.ps1\\AddSessionHost",
  "properties": {
    "hostPoolName": "${azurerm_virtual_desktop_host_pool.hp.name}",
    "registrationInfoToken": "${azurerm_virtual_desktop_host_pool_registration_info.reg.token}"
  }
}
SETTINGS
}

*/