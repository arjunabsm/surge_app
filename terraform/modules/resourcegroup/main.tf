provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "resource_group" {
  name     = "${var.environment}-app-rg"
  location = var.location

  tags = {
    environment = var.environment
    project     = "surge-dev"
    owner       = "Surge Devops Team"
  }
}
