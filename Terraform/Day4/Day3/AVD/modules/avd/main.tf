
resource "azurerm_virtual_network" "vnet" {
    name = "avd-vnet"
    location = var.location
    resource_group_name = var.resource_group_name
    address_space = ["10.0.0.0/16"]
    tags = var.tags
}

resource "azurerm_subnet" "subnet" {
  name                 = "avd-subnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.0.0/24"]
}

# Host Pool
resource "azurerm_virtual_desktop_host_pool" "hp" {
  name                = "avd-hostpool"
  location            = var.location
  resource_group_name = var.resource_group_name

  type                     = "Pooled"
  load_balancer_type       = "DepthFirst"
  maximum_sessions_allowed = 10

  tags = var.tags
}

#Registratoin Token
resource "azurerm_virtual_desktop_host_pool_registration_info" "reg" {
  hostpool_id     = azurerm_virtual_desktop_host_pool.hp.id
  expiration_date = timeadd(timestamp(), "24h")
}

# Workspace
resource "azurerm_virtual_desktop_workspace" "ws" {
  name                = "avd-workspace"
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

# Application Group
resource "azurerm_virtual_desktop_application_group" "dag" {
  name                = "avd-dag"
  location            = var.location
  resource_group_name = var.resource_group_name

  type         = "Desktop"
  host_pool_id = azurerm_virtual_desktop_host_pool.hp.id

  tags = var.tags
}

# Associate Workspace + App Group
resource "azurerm_virtual_desktop_workspace_application_group_association" "assoc" {
  workspace_id         = azurerm_virtual_desktop_workspace.ws.id
  application_group_id = azurerm_virtual_desktop_application_group.dag.id
}

# NICs
resource "azurerm_network_interface" "nic" {
  count               = var.vm_count
  name                = "avd-nic-${count.index}"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
  }

  tags = var.tags
}

# Session Host VMs
resource "azurerm_windows_virtual_machine" "vm" {
  count               = var.vm_count
  name                = "avd-vm-${count.index}"
  location            = var.location
  resource_group_name = var.resource_group_name
  size                = "Standard_D2as_v5"

  admin_username = var.admin_username
  admin_password = var.admin_password

  network_interface_ids = [
    azurerm_network_interface.nic[count.index].id
  ]

  zone = tostring((count.index % 3) + 1)

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