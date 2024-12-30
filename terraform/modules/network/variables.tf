variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "environment" {
  description = "Environment"
  type        = string
  default     = "dev"  
}

variable "location" {
  description = "Azure region"
  type        = string
  default     = "East US"  
}

variable "network_security_rule" {
  type = list(object({
    rule_name                                  = string
    priority                                   = string
    direction                                  = string
    access                                     = string
    protocol                                   = string
    source_port_range                          = string
    destination_port_range                     = string
    source_address_prefix                      = string
    source_address_prefixes                    = list(string)
    destination_address_prefix                 = string
    destination_address_prefixes               = list(string)
    destination_application_security_group_ids = list(string)
    network_security_group_name                = string
  }))
}

variable "subnet_nsg_map" {
  type        = map(any)
  description = "Subnets and corresponding nsg names"
  default     = {}
}
variable "tags" {
  type        = map(any)
  description = "Componenet tags"
  default     = {}
}

variable "project" {
  type        = string
  description = "Project name"  
}

variable "azure_nsg_mgmt_ip_whitelist" {
  type        = list(string)
  description = "IP whitelist used in source address prefixes"
}

variable "placetype" {
  type        = string
  description = "Platform placetype"
}