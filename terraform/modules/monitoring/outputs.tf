output "log_analytics_workspace_id" {
  value = azurerm_log_analytics_workspace.log_analytics.id
}

output "aks_diagnostics_id" {
  value = azurerm_monitor_diagnostic_setting.aks_diagnostics.id
}