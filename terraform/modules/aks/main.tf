provider "azurerm" {
  features {}
}

module "resource_group" {
  source      = "./modules/resource_group"
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                = "${var.environment}-app-aks"
  location            = module.resource_group.resource_group_location
  resource_group_name = module.resource_group.resource_group_name
  dns_prefix          = "surge-${var.environment}"

default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = var.default_node_pool_vm_size
  }

identity {
    type = "SystemAssigned"
  }

network_profile {
    network_plugin = "azure"
    network_policy = "azure"
  }
}
