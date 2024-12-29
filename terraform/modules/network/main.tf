provider "azurerm" {
  features {}
}

resource "azurerm_virtual_network" "vnet" {
  name                = "${var.environment}-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = var.location
  resource_group_name = var.resource_group_name
}

locals {
  subnet_names = ["${local.place_id}-aks-subnet", "${local.place_id}-db-subnet", "${local.place_id}-app-subnet"]
  subnet_prefixes = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

resource "azurerm_subnet" "subnet" {
  for_each             = zipmap(local.subnet_names, local.subnet_prefixes)
  name                 = each.key
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [each.value]
}

resource "azurerm_network_security_group" "network_security_group" {
  for_each            = local.subnet_nsg_map
  name                = each.value
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

resource "azurerm_network_security_rule" "network_security_rule" {
  for_each                                   = local.network_security_rules
  name                                       = each.key
  priority                                   = each.value.priority
  direction                                  = each.value.direction
  access                                     = each.value.access
  protocol                                   = each.value.protocol
  source_port_range                          = each.value.source_port_range
  destination_port_range                     = each.value.destination_port_range
  source_address_prefix                      = each.value.source_address_prefix
  destination_address_prefix                 = each.value.destination_address_prefix
  resource_group_name                        = var.resource_group_name
  network_security_group_name                = azurerm_network_security_group.network_security_group[each.key].name
  depends_on = [
    azurerm_network_security_group.network_security_group
  ]
}

resource "azurerm_subnet_network_security_group_association" "subnet_nsg_assoc" {
  subnet_id                 = azurerm_subnet.subnet.id
  network_security_group_id = azurerm_network_security_group.network_security_group.id
}