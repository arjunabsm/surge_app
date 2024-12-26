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