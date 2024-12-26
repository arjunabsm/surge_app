provider "azurerm" {
  features {}
}

terraform {
  backend "azurerm" {
    resource_group_name   = var.backend_resource_group_name
    storage_account_name  = var.backend_storage_account_name
    container_name        = var.backend_container_name
    key                   = "terraform.tfstate"
  }
}

module "acr" {
  source = "./modules/acr"
}

module "network" {
  source              = "./modules/network"
  resource_group_name = var.resource_group_name
  environment         = var.environment
}

module "aks" {
  source              = "./modules/aks"
  resource_group_name = var.resource_group_name
  location            = var.location
}

module "storage" {
  source              = "./modules/storage"
  resource_group_name = var.resource_group_name
  location            = var.location
}

module "monitoring" {
  source              = "./modules/monitoring"
  resource_group_name = var.resource_group_name
  location            = var.location
}
