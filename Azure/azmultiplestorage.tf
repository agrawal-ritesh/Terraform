resource "azurerm_storage_account" "tfappstoragess"{
    count = 3
    name ="${count.index}appstoretfmultiple"
    location ="East US"
    resource_group_name ="tf_app_rg"
    account_tier = "Standard"
    account_replication_type ="LRS"
    account_kind ="StorageV2"
    depends_on =[azurerm_resource_group.tfapprg]
}