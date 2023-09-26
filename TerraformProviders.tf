#Terraform Providers template
terraform{
    required_providers{
        azurerm = {
            source = "hashicorp/azurerm"
            version = "3.74.0"
        }
    }
}
provider "azurerm" {
    # configuration options
}


// Terraform Provider are the plugins that enables to interact with APIs.
// This includes Cloud providers and Software as a services. 
//These pulgins tells terreform to which service it needs to ineteract with. 
