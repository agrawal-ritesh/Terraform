

resource "azurerm_resource_group" "rg" {
    name = var.resource_group_name
    location = var.location
    tags = var.tags
}

module "avd" {
    source = "./modules/avd"
    location = var.location
    resource_group_name = azurerm_resource_group.rg.name
    vm_count = var.vm_count
    admin_username = var.admin_username
    admin_password = var.admin_password
    tags = var.tags
}