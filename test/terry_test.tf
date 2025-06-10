terraform {
  required_version = ">= 1.5.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.0"
    }
    azuread = {
      source  = "hashicorp/azuread" 
      version = ">= 2.0"
    }
  }
}

# Variables for authentication
variable "subscription_id" {
  description = "Azure Subscription ID"
  type        = string
  sensitive   = true
}

variable "tenant_id" {
  description = "Azure Tenant ID"
  type        = string
  sensitive   = true
}

variable "client_id" {
  description = "Azure Client ID (Service Principal)"
  type        = string
  sensitive   = true
}

variable "client_secret" {
  description = "Azure Client Secret (Service Principal)"
  type        = string
  sensitive   = true
}

# Configure the Azure Provider
provider "azurerm" {
  features {}
  
  subscription_id = var.subscription_id
  tenant_id       = var.tenant_id
  client_id       = var.client_id
  client_secret   = var.client_secret
}

provider "azuread" {
  tenant_id     = var.tenant_id
  client_id     = var.client_id
  client_secret = var.client_secret
}

# Module configuration for testing
module "test_resource_group" {
  source = "./.."

  name     = "terry-test-rg"
  location = "eastus"  # All lowercase to comply with validation

  tags = {
    Environment = "test"
    Project     = "terraform-module-demo"
    ManagedBy   = "terry"
    CreatedBy   = "service-principal"
  }

  # Enable resource lock for testing
  enable_resource_lock = true
  lock_level           = "CanNotDelete"
  lock_notes           = "Protected resource group - managed by Terry"
}

# Output relevant resource information
output "resource_group_id" {
  description = "The ID of the created resource group"
  value       = module.test_resource_group.id
}

output "resource_group_name" {
  description = "The name of the created resource group"
  value       = module.test_resource_group.name
}

output "resource_group_location" {
  description = "The location of the created resource group"
  value       = module.test_resource_group.location
}

output "effective_tags" {
  description = "All tags applied to the resource group"
  value       = module.test_resource_group.effective_tags
}
