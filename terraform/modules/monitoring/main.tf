provider "azurerm" {
  features {}
}

module "resource_group" {
  source      = "./modules/resource_group"
}

module "azurerm_kubernetes_cluster" {
  source      = "./modules/aks"
}

resource "azurerm_log_analytics_workspace" "log_analytics" {
  name                = "surge-app-${var.environment}-log-analytics"
  location            = module.resource_group.resource_group_location
  resource_group_name = module.resource_group.resource_group_name
  sku                 = var.monitoring_sku
}

resource "azurerm_monitor_diagnostic_setting" "aks_diagnostics" {
  name                       = "surge-aks-${var.environment}-log-analytics"
  target_resource_id         = module.azurerm_kubernetes_cluster.aks.id
  log_analytics_workspace_id = azurerm_log_analytics_workspace.log_analytics.id

  dynamic "log" {
    for_each = [
      "kube-apiserver",
      "kube-controller-manager",
      "kube-scheduler",
      "kube-audit",
      "kube-audit-admin"
    ]
    content {
      category = log.value
      enabled  = true
    }
  }

  dynamic "metric" {
    for_each = [
      "AllMetrics"
    ]
    content {
      category = metric.value
      enabled  = true
    }
  }
}
