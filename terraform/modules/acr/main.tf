provider "azurerm" {
  features {}
}
resource "azurerm_container_registry" "acr" {
  name                = "${var.environment}surgeacrregistry"
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = var.acr_sku
  admin_enabled       = true
}
