# Terraform
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "2.40.0"
    }
  }
}

#Azure provider
provider "azurerm" {
  features {}
}

#Get CloudAcademy Lab Resource Group
data "azurerm_resource_group" "rg" {
  name = "REPLACEME"
}

#Create virtual network
resource "azurerm_virtual_network" "vnet" {
  name                = "vnet-modchallenge-${azurerm_resource_group.rg.location}-001"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

# Create subnet
resource "azurerm_subnet" "subnet" {
  name                 = "snet-modchallenge-${azurerm_resource_group.rg.location}-001"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.0.0/24"]
}

module "webserver" {
    source = "../../"

    subnet_id = azurerm_subnet.subnet.id
    resource_group_name = azurerm_resource_group.rg.name
    location = azurerm_resource_group.rg.location

    servername = var.servername
    size = "Basic_A1"

}
