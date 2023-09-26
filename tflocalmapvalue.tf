#Map the values in the script.   

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

locals{                               
    resource_group_name = "webapprg"
    location = "West Europe"
    virtual_network ={
        name ="vnet"
        adress_space = "10.0.0.0/16"  //Assigning the locals for values.
    }
}
resource "azurerm_resource_group" "example1"{
    name =local.resource_group_name            
    location =local.location
}
resource "azurerm_virtual_network" "vnetworking"{
    name =local.virtual_network.name        //Maping the names for values from locals.
    location =local.location                     
    resource_group_name =local.resource_group_name
    address_space =[local.virtual_network.adress_space]  //Maping the names for values from locals.
    dns_servers = ["10.0.0.5", "10.0.0.6"]

    subnet {
        name ="subnetA"
        address_prefix = "10.0.1.0/24"
    }

    subnet {
        name ="subnetB"
        address_prefix ="10.0.2.0/24"
    }
    depends_on =[azure_resource_group.example1]
}