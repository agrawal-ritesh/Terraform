terraform {
    required_providers {
      azurerm = {
        source ="hashicorp/azurerm"
        version = "3.75.0"
      }
    }
}
provider "azurerm"{
    subscription_id =""
    tenant_id =""
    client_id =""
    client_secret =""
    features {}
}
resource "azurerm_resource_group" "example1"{
    name =""
    location =""
}
resource "azurerm_virtual_network" "vnetworking"{
    name =""
    location =""
    resource_group_name =""
    address_space =["10.0.0.0/16"]
    dns_servers = ["10.0.0.5", "10.0.0.6"]
    depends_on =[azure_resource_group.example1]
}
resource "azurerm_subnet" "subntting1"P{
    name ="Subnet1"
    resource_group_name = ""
    virtual_network_name = ""
    address_prefix = "10.0.1.0/24"
}