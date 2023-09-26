terraform{
    required_providers{
        azurerm = {
            source = "azurerm"
            version = "3.75.0"
        }
    }
}
provider "azurerm"{
    suscription_ID = ""
    tenant_ID = ""
    client_ID =""
    client_secret = ""
    features{}
}
resource "azurerm_resource_group" "example" {
    name = "app-grp"
    location = "North-west"
}

