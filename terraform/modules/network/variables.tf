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
