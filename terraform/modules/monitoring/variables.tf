variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}
variable "location" {
  description = "Azure region"
  type        = string
  default     = "East US"
}
variable "environment" {
  description = "Environment"
  type        = string
  default     = "dev"  
}
variable "monitoring_sku" {
  description = "The SKU of the Azure Monitor"
  type        = string
  default     = "PerGB2018"  
}
