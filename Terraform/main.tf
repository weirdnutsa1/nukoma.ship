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
  address_space       = ["10.252.0.0/16"]
  location            = azurerm_resource_group.NUKOMASHIP.location
  resource_group_name = azurerm_resource_group.NUKOMASHIP.name
}


resource "azurerm_subnet" "subnet1bymatthias" {
  name                 = "subnet1bymatthias"
  resource_group_name  = azurerm_resource_group.NUKOMASHIP.name
  virtual_network_name = azurerm_virtual_network.hiasnet.name
  address_prefixes     = ["10.252.1.0/24"]

}
  resource "azurerm_network_interface" "interalhiasni" {
  name                = "example-nic"
  location            = azurerm_resource_group.NUKOMASHIP.location
  resource_group_name = azurerm_resource_group.NUKOMASHIP.name
   ip_configuration {
    name                          = "internalhiasip"
    subnet_id                     = azurerm_subnet.subnet1bymatthias.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "hiasvm" {
  name                = "hias-machine"
  resource_group_name = azurerm_resource_group.NUKOMASHIP.name
  location            = azurerm_resource_group.NUKOMASHIP.location
  size                = "Standard_F2"
  admin_username      = "adminuser"
  network_interface_ids = [
    azurerm_network_interface.interalhiasni.id,
  ]

  admin_ssh_key {
    username   = "adminuser"
    public_key = file(".ssh/id_rsa.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
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
  name                = "kostya-vnet"
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