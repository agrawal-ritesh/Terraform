
resource "azurerm_network_interface" "nic" {
    count = var.vm_count
    name = "vm-nic-${count.index}"
    location = var.location
    resource_group_name = var.resource_group_name

    ip_configuration {
        name = "internal"
        subnet_id = var.subnet_id
        private_ip_address_allocation = "Dynamic"
    }

    tags = var.tags
}

resource "azurerm_windows_virtual_machine" "vm" {
    count = var.vm_count
    name = "vm-ha-${count.index}"
    location = var.location
    resource_group_name = var.resource_group_name
    size = var.vm_size
    admin_username = var.admin_username
    admin_password = var.admin_password
    network_interface_ids = [
        azurerm_network_interface.nic[count.index].id
    ]
    zone = tostring((cound.index % 3) + 1)

    os_disk {
        caching = "ReadWrite"
        storage_account_type = "Standard_LRS"
    }
    source_image_reference {
        publisher = "MicrosoftWindowsServer"
        offer = "WindowsServer"
        sku = "2022-Datacenter"
        version = "latest"
    }
    tags = var.tags
}