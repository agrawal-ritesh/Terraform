/*A local value assigns a name to an expression, 
so you can use the name multiple times within a module instead of repeating the expression.

For Example : you want to change the location of resource in script, then you need to change it
in every block wherever the location value is present. 
Instead of doind that you can use Local variable and give it a value. (Once chnaging its value, every block will chang accoridingly.)
*/

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

locals{                                #Assigning the short name to expressions
    resource_group_name = "webapprg"
    location = "West Europe"
}
resource "azurerm_resource_group" "example1"{
    name =local.resource_group_name           # Assiging the local variable to value. 
    location =local.location
}
resource "azurerm_virtual_network" "vnetworking"{
    name =local.resource_group_name                 
    location =local.location                     # Assiging the local variable for value.
    resource_group_name =""
    address_space =["10.0.0.0/16"]
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