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

