data "azurerm_subnet" "subnet_aks" {
  name                 = "${local.place_id}-aks-subnet"
  virtual_network_name = local.virtual_network_name
  resource_group_name  = local.resource_group_name
}