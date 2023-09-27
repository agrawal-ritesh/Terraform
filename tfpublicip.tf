terraform{
    required_providers{
        azurerm ={
            source ="hashicorp/azurerm"
            version = "3.75.0"
        }
    }
}
provider "azurerm"{
    subscription_id =""
    tenant_id =""
    client_id =""
    slient_secret =""
    features{}
}
locals{
    resource_group_name ="demo_rg"
    location ="North Europe"

}
resource "azurerm_resource_group" "demorg"{
    name ="demo_rg"
    location =local.location
}
resource "azurerm_virtual_network" "vnetwork"{
    name =""
    location = local.location
    resource_group_name = local.resource_group_name
    address_space =""
    dns_servers =""
    depends_on = [azurerm_resource_group.demorg]
}
resource "azurerm_subnet" "subnetting1" {
    name ="subnetA"
    resource_group_name = local.resource_group_name
    virtual_network_name = ""
    address_prefix = "10.0.1.0/24"
  
}
resource "azurerm_network_interface" "demonetwork"{
    name =""
    location =local.location
    resource_group_name =local.resource_group_name

    ip_configuration{
        name ="internal"
        subnet_id =azurerm_subnet.subnetting1.id  #Subnet ID automatically inetracts with Azure and locates the Subnet ID which comes in use.        private_ip_address_allocation ="Dynamic"

    }
}
resource "azurerm_public_ip" "demoip"{
    name =""
    location = local.location
    resource_group_name =local.resource_group_name
    allocation_method ="Static"
    depends_on = [azurerm_resource_group_name.demorg]
}
