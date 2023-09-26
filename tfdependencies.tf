#Terraform does not goes in orer when creating the resources
# Even though your first block is creation of resource group, it doesn't means that the first block will get executed then only it will move to second one for another resource creation. 
#This means that there is no order for creating resources from configuration file 

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
resource "azurerm_resource_group" "example1"{
    name =""
    location =""
}
resource "azurerm_storage_account" "example2" {
    name =""
    location=""
    resource_group_name =""
    account_tier =""
    account_replication_type =""
    account_kind =""
    depends_on = [azure_resource_group.example1] # It means once the resource group creation is done, after that only this blok will get executed.

}
resource "azurerm_storage_container" "example3"{
    name =""
    storage_account_name =""
    container_access_type =""
    depends_on =[azurerm_sotrage_account.example2]
}
resource "azurerm_storage_blob" "example4"{
    name =""
    storage_account_name =""
    storage_container_name =""
    type =""
    source =""
    depends_on =[azurerm_storage_container.example4]
}