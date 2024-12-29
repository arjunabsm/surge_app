locals {
  place_id             = "${var.project}-${var.environment}"
  resource_group_name  = "${local.place_id}-network-rg"
  virtual_network_name = "${local.place_id}-vnet"
  subnet_names         = ["${local.place_id}-aks-subnet", "${local.place_id}-db-subnet", "${local.place_id}-app-subnet"]
  subnet_nsg_map       = { for subnet in local.subnet_names : subnet => format("%s-nsg", subnet) }
  tags = {
    customercode    = var.project
    environmenttype = var.environment
    placeid         = local.place_id
    location        = var.location
  }
  network_security_rules = [
    {
      rule_name                                  = "allow-aks-subnet-in"
      priority                                   = "100"
      direction                                  = "Inbound"
      access                                     = "Allow"
      protocol                                   = "*"
      source_port_range                          = "*"
      destination_port_range                     = "*"
      source_address_prefix                      = null
      source_address_prefixes                    = data.azurerm_subnet.subnet_aks.address_prefixes
      destination_address_prefix                 = "VirtualNetwork"
      destination_address_prefixes               = null
      destination_application_security_group_ids = null
      network_security_group_name                = "${local.place_id}-aks-subnet-nsg"
    },
    {
      rule_name                                  = "allow-lb-probe-in"
      priority                                   = "200"
      direction                                  = "Inbound"
      access                                     = "Allow"
      protocol                                   = "*"
      source_port_range                          = "*"
      destination_port_range                     = "*"
      source_address_prefix                      = "168.63.129.16/32"
      source_address_prefixes                    = null
      destination_address_prefix                 = "VirtualNetwork"
      destination_address_prefixes               = null
      destination_application_security_group_ids = null
      network_security_group_name                = "${local.place_id}-aks-subnet-nsg"
    },
    {
      rule_name                                  = "allow-appgw-in"
      priority                                   = "300"
      direction                                  = "Inbound"
      access                                     = "Allow"
      protocol                                   = "*"
      source_port_range                          = "*"
      destination_port_range                     = "*"
      source_address_prefix                      = data.azurerm_public_ips.pip_application_gateway_ips.public_ips.0.ip_address
      source_address_prefixes                    = null
      destination_address_prefix                 = "*"
      destination_address_prefixes               = null
      destination_application_security_group_ids = null
      network_security_group_name                = "${local.place_id}-aks-subnet-nsg"
    },
    {
      rule_name                                  = "allow-node-to-node-in"
      priority                                   = "400"
      direction                                  = "Inbound"
      access                                     = "Allow"
      protocol                                   = "*"
      source_port_range                          = "*"
      destination_port_range                     = "*"
      source_address_prefix                      = null
      source_address_prefixes                    = data.azurerm_subnet.subnet_aks.address_prefixes
      destination_address_prefix                 = null
      destination_address_prefixes               = data.azurerm_subnet.subnet_aks.address_prefixes
      destination_application_security_group_ids = null
      network_security_group_name                = "${local.place_id}-aks-subnet-nsg"
    },
    {
      rule_name                                  = "allow-node-to-pod-in"
      priority                                   = "500"
      direction                                  = "Inbound"
      access                                     = "Allow"
      protocol                                   = "*"
      source_port_range                          = "*"
      destination_port_range                     = "*"
      source_address_prefix                      = null
      source_address_prefixes                    = data.azurerm_subnet.subnet_aks.address_prefixes
      destination_address_prefix                 = "192.168.0.0/16"
      destination_address_prefixes               = null
      destination_application_security_group_ids = null
      network_security_group_name                = "${local.place_id}-aks-subnet-nsg"
    },
    {
      rule_name                                  = "allow-pod-to-pod-in"
      priority                                   = "700"
      direction                                  = "Inbound"
      access                                     = "Allow"
      protocol                                   = "*"
      source_port_range                          = "*"
      destination_port_range                     = "*"
      source_address_prefix                      = "192.168.0.0/16"
      source_address_prefixes                    = null
      destination_address_prefix                 = "192.168.0.0/16"
      destination_address_prefixes               = null
      destination_application_security_group_ids = null
      network_security_group_name                = "${local.place_id}-aks-subnet-nsg"
    },
    {
      rule_name                                  = "deny-vnet-in"
      priority                                   = "4000"
      direction                                  = "Inbound"
      access                                     = "Deny"
      protocol                                   = "*"
      source_port_range                          = "*"
      destination_port_range                     = "*"
      source_address_prefix                      = "VirtualNetwork"
      source_address_prefixes                    = null
      destination_address_prefix                 = "VirtualNetwork"
      destination_address_prefixes               = null
      destination_application_security_group_ids = null
      network_security_group_name                = "${local.place_id}-aks-subnet-nsg"
    },
    {
      rule_name                                  = "deny-mgmt-vnet-out"
      priority                                   = "4000"
      direction                                  = "Outbound"
      access                                     = "Deny"
      protocol                                   = "*"
      source_port_range                          = "*"
      destination_port_range                     = "*"
      source_address_prefix                      = "VirtualNetwork"
      source_address_prefixes                    = null
      destination_address_prefix                 = null
      destination_address_prefixes               = var.azure_nsg_mgmt_ip_whitelist
      destination_application_security_group_ids = null
      network_security_group_name                = "${local.place_id}-aks-subnet-nsg"
    },
    {
      rule_name                                  = "allow-mgmt-vnet-db-1521-out"
      priority                                   = "1000"
      direction                                  = "Outbound"
      access                                     = "Allow"
      protocol                                   = "*"
      source_port_range                          = "*"
      destination_port_range                     = "1521"
      source_address_prefix                      = "VirtualNetwork"
      source_address_prefixes                    = null
      destination_address_prefix                 = null
      destination_address_prefixes               = var.azure_nsg_mgmt_ip_whitelist
      destination_application_security_group_ids = null
      network_security_group_name                = "${local.place_id}-db-subnet-nsg"
    },
    {
      rule_name                                  = "allow-aks-subnet-in"
      priority                                   = "1000"
      direction                                  = "Inbound"
      access                                     = "Allow"
      protocol                                   = "*"
      source_port_range                          = "*"
      destination_port_range                     = "*"
      source_address_prefix                      = null
      source_address_prefixes                    = data.azurerm_subnet.subnet_aks.address_prefixes
      destination_address_prefix                 = "VirtualNetwork"
      destination_address_prefixes               = null
      destination_application_security_group_ids = null
      network_security_group_name                = "${local.place_id}-app-subnet-nsg"
    }
  ]
}