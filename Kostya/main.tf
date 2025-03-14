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
resource "azurerm_resource_group" "NUKOMASHIP2" {
  name     = "nukoma.ship.kostya"
  location = "West Europe"
   tags = {
    owner = "konstantin.mikhailovsky@redbull.com"
  }

}

resource "azurerm_virtual_network" "hiasnet" {
  name                = "hias-vnet-2"
  address_space       = ["10.252.0.0/16"]
  location            = azurerm_resource_group.NUKOMASHIP2.location
  resource_group_name = azurerm_resource_group.NUKOMASHIP2.name
}

resource "azurerm_subnet" "subnet1bykostya" {
  name                 = "subnet1bykostya"
  resource_group_name  = azurerm_resource_group.NUKOMASHIP2.name
  virtual_network_name = azurerm_virtual_network.hiasnet.name
  address_prefixes     = ["10.252.2.0/24"]
  }