terraform {
    required_providers {
        azurerm = {
            source ="hasicorp/azurerm"
            version = "3.75.0"
        }
    }
}
provider "azurerm"{
subscription_id =""
tenant_id =""
client_id =""
client_secret =""
features{}
}
resource "azurerm_resource_group" "exapmle"{
    name =""
    location =""
}
resource "azure_storage_account" "example"{
    name =""
    resource_group_name =""
    location =""
    account_tier =""
    account_replication_type =""
    account_kind =""
}
resource "azurerm_storage_container" "example"{
    name = ""
    storage_account_name =""
    container_access_type ="blob"
}
