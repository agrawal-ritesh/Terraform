terraform{
    required_providers{
        azurerm = {
            source ="hashicorp/azurerm"
            version = "3.74.0"
        }
    }
}
provider "azurerm" {
    subscription_id = "6883dfc1-f1f6-41c4-a578-5dcbd9ef10e0"
    tenant_id ="a70bb139-71ea-4653-b99f-fc3ca97b02fe"
    client_id ="8edc95c9-35bf-417a-be55-268943fa556a"
    features {}
}
resource "azurerm_resource_group" "tfapprg"{
    name = "tf_app_rg"
    location ="East US"
}
