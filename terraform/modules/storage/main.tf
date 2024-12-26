provider "azurerm" {
  features {}
}

module "resource_group" {
  source      = "./modules/resource_group"
}

resource "azurerm_storage_account" "storage" {
  name                     = "${var.environment}-app-sa"
  resource_group_name      = module.resource_group.resource_group_name
  location                 = module.resource_group.resource_group_location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "container" {
  name                  = "${var.environment}-app-container"
  storage_account_id    = azurerm_storage_account.storage.id
  container_access_type = "private"
}