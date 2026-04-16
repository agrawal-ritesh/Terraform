
resource "azurerm_resource_group" "rg" {
    name = var.resource_group_name
    location = var.location
}

resource "azurerm_virtual_network" "vnet" {
    name = "vnet-us"
    location = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.vnet.name
    address_space = ["10.0.0.0/16"]
    tags = var.tags
}

resource "azurerm_subnet" "subnet" {
    name = "subnet-us"
    virtual_network_name = azurerm_virtual_network.vnet.name
    resource_group_name = azurerm_resource_group.rg.name 
    address_prefixes = ["10.0.0.0/24"]
}

module "vm" {
    source = "./modules/vm"
    vm_count = var.vm_count
    vm_size = var.vm_size
    location = var.location
    resource_group_name = azurerm_resource_group.rg.name
    subnet_id = azurerm_subnet.subnet.id
    admin_username = var.admin_username
    admin_password = var.admin_password
    tags = var.tags
}