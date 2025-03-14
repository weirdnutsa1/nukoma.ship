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
  name     = "nukoma.ship.1"
  location = "West Europe"
   tags = {
    owner = "nutsa.tsamalashvili@gmail.com"
  }

}

resource "azurerm_virtual_network" "hiasnet" {
  name                = "hias-vnet.Nutsa"
  address_space       = ["10.252.0.0/16"]
  location            = azurerm_resource_group.NUKOMASHIP.location
  resource_group_name = azurerm_resource_group.NUKOMASHIP.name
}

resource "azurerm_subnet" "subnet1byNutsa" {
  name                 = "subnet1byNutsa"
  resource_group_name  = azurerm_resource_group.NUKOMASHIP.name
  virtual_network_name = azurerm_virtual_network.hiasnet.name
  address_prefixes     = ["10.252.3.0/24"]
  }