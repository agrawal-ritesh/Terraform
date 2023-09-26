#Upload files to Blob to container

terraform{
    required_providers{
        azurerm = {
            source = "hashicorp/azurerm"
            version = "3.75.0"
        }
    }
}
provider "azurerm" {
    subscription_id =""
    tenant_id = ""
    client_id =""
    client_secret =""
    features{}
}
resource "azurerm_resource_group" "example"{
    name =""
    location =""
}
resource "azurerm_storage_account" "example" {
    name =""
    location=""
    resource_group_name =""
    account_tier =""
    account_replication_type =""
    account_kind =""

}
resource "azurerm_storage_container" "example"{
    name =""
    storage_account_name =""
    container_access_type =""
}
resource "azurerm_storage_blob" "example"{
    name =""
    storage_account_name =""
    storage_container_name =""
    type =""
    source =""
}
