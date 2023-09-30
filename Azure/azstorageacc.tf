resource "azurerm_storage_account" "tfappstorage"{
    name ="appstoretf"
    location ="East US"
    resource_group_name ="tf_app_rg"
    account_tier = "Standard"
    account_replication_type ="LRS"
    account_kind ="StorageV2"
}