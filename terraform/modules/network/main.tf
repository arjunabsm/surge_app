provider "azurerm" {
  features {}
}

module "resource_group" {
  source      = "./modules/resource_group"
}

resource "azurerm_virtual_network" "vnet" {
  name                = "${var.environment}-Vnet"
  address_space       = ["10.0.0.0/16"]
  location            = module.resource_group.resource_group_location
  resource_group_name = module.resource_group.resource_group_name
}

resource "azurerm_subnet" "subnet" {
  name                 = "${var.environment}-Subnet"
  resource_group_name  = module.resource_group.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}