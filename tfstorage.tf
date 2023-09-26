terraform{
    required_providers{
        azurerm = {
            source = "Hashicorp/azurerm"
            version = "3.75.0"
        }
    }
}
provider "azurerm"{
    subscription_id =""
    tenant_id =""
    client_id = ""
    client_secret =""
    features{}
}
resource "azurerm_resource_group" "example"{ //It will check that this undergoing resource it been deployed within this RG. 
    name =""
    location =""               // when creating the storage resource, the resource group block is there which ensures that whenever you create any resource, deploys under this resource group. 
}
resource "azurerm_storage_account" "example" {
    name =""
    resource_group_name=""
    account_tier =""
    account_replication_type=""
    account_kind =""
}