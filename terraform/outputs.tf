output "aks_cluster_name" {
  value = module.aks.cluster_name
}

output "aks_cluster_kubeconfig" {
  value = module.aks.kubeconfig
}

output "acr_login_server" {
  value = module.acr.acr_login_server
}

output "acr_admin_username" {
  value = module.acr.acr_admin_username
}

output "acr_admin_password" {
  value = module.acr.acr_admin_password
}