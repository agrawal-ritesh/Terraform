# Modules

resource "azurerm_resource_group" "rg" {
    name = var.resource_group_name
    location = var.location
}

module "network" {
    source = "./modules/network"
    resource_group_name = var.resource_group_name
    location = var.location
}

module "subnet" {
    source = "./modules/subnet"
    resource_group_name = var.resource_group_name
    location = var.location
    vnet_name = module.network.vnet_name
}

module "nsg" {
    source = "./modules/nsg"
    resource_group_name = var.resource_group_name
    location = var.location
}

module "nic" {
    source = "./modules/nic"
    resource_group_name = var.resource_group_name
    location = var.location
    subnet_id = module.subnet.subnet_id
    nsg_id = module.nsg.nsg_id
}

module "vm" {
    source = "./modules/vm"
    resource_group_name = var.resource_group_name
    location = var.location
    nic_id = module.nic.nic_id
    admin_username = var.admin_username
    admin_password = var.admin_password
}
