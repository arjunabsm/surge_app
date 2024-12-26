provider "azurerm" {
  features {}
}

module "resource_group" {
  source      = "./modules/resource_group"  
}

resource "azurerm_container_registry" "acr" {
  name                = "${var.environment}surgeacrregistry"
  resource_group_name = module.resource_group.resource_group_name
  location            = module.resource_group.resource_group_location
  sku                 = var.acr_sku
  admin_enabled       = true
}
