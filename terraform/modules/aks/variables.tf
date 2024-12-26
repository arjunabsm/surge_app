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
variable "default_node_pool_vm_size" {
  description = "Default node pool VM size"
  type        = string
  default     = "Standard_DS2_v2"
}
