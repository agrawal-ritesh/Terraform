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
    esource_group_name = var.resource_group_name
    location = var.location
}

module "nsg" {
    source = "./modules/nsg"
    esource_group_name = var.resource_group_name
    location = var.location
}

module "nic" {
    source = "./modules/nic"
    esource_group_name = var.resource_group_name
    location = var.location
    subnet_id = module.subnet.subnet_id
    nsg_id = module.nsg.nsg_id
}

module "vm" {
    source = "./modules/vm"
    esource_group_name = var.resource_group_name
    location = var.location
    nic_id = module.nic.nic_id
    admin_username = var.admin_username
    admin_password = var.admin_password
}
