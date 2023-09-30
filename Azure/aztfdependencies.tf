
locals {
    resouce_group_name = "az_rg_test"
    location = "East US"
}
resource "azurerm_resource_group" "azrgtest"{
    name = "az_rg_test"
    location = "East US"
}
resource "azurerm_storage_account" "azstoragetest"{
    name ="appstorageaztest"
    location = local.location
    resource_group_name = local.resouce_group_name
    account_tier = "Standard"
    account_replication_type = "LRS"
    account_kind = "StorageV2"
    depends_on =[
        azurerm_resource_group.azrgtest
    ]
}
resource "azurerm_storage_container" "data"{
    name = "data"
    storage_account_name = "appstorageaztest"
    container_access_type = "blob"
    depends_on = [
        azurerm_storage_account.azstoragetest
    ]
}