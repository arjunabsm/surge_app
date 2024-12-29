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

module "resource_group" {
  source     = "./modules/resourcegroup"
  environment = var.environment
  location    = var.location
  resource_group_name = var.resource_group_name
}

module "acr" {
  source = "./modules/acr"
  resource_group_name = var.resource_group_name
  acr_sku = var.acr_sku
}

module "network" {
  source              = "./modules/network"
  resource_group_name = module.resource_group.resource_group_name
  environment         = var.environment
  network_security_rule = var.network_security_rule
}

module "aks" {
  source              = "./modules/aks"
  resource_group_name = module.resource_group.resource_group_name
  location            = var.location
  environment         = var.environment
}

module "storage" {
  source              = "./modules/storage"
  resource_group_name = module.resource_group.resource_group_name
  location            = var.location
}

module "monitoring" {
  source              = "./modules/monitoring"
  resource_group_name = module.resource_group.resource_group_name
  location            = var.location
}
