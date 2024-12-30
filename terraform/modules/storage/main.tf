provider "azurerm" {
  features {}
}

resource "azurerm_storage_account" "storage" {
  name                     = "${var.environment}-app-sa"
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "container" {
  name                  = "${var.environment}-app-container"
  storage_account_id    = azurerm_storage_account.storage.id
  container_access_type = "private"
}