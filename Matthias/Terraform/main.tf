# We strongly recommend using the required_providers block to set the
# Azure Provider source and version being used
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}

provider "azurerm" {
  features {}
}

# Create a resource group
resource "azurerm_resource_group" "NUKOMASHIP" {
  name     = "nukoma.ship"
  location = "West Europe"
   tags = {
    owner = "matthias.leckel@redbull.com"
  }


}
resource "azurerm_virtual_network" "hiasnet" {
  name                = "hias-vnet"
  address_space       = ["10.0.0.0/24"]
  location            = azurerm_resource_group.NUKOMASHIP.location
  resource_group_name = azurerm_resource_group.NUKOMASHIP.name
}




