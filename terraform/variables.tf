variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}
variable "location" {
  description = "Azure region"
  type        = string
  default     = "East US"
}
variable "backend_resource_group_name" {
  description = "The name of the resource group for the backend storage account"
  type        = string
}
variable "backend_storage_account_name" {
  description = "The name of the storage account for the backend"
  type        = string
}
variable "backend_container_name" {
  description = "The name of the storage container for the backend"
  type        = string
}
variable "environment" {
  description = "Environment"
  type        = string
  default     = "dev"  
}
variable "acr_sku" {
  description = "The SKU of the Azure Container Registry"
  type        = string
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