output "aks_cluster_name" {
  value = module.aks.cluster_name
}
output "aks_cluster_kubeconfig" {
  value = module.aks.kubeconfig
}
output "aks_id" {
  value = azurerm_kubernetes_cluster.aks.id
}