# Test configuration for Terraform Module Demo using Service Principal
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

# Module configuration for testing
module "test_resource_group" {
  source = "./.."

  # Required parameters
  name     = var.name
  location = var.location

  # Optional parameters
  tags                 = var.tags
  enable_resource_lock = var.enable_resource_lock
  lock_level           = var.lock_level
  lock_notes           = var.lock_notes
  role_assignments     = var.role_assignments
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

output "resource_summary" {
  description = "Summary of the resource group configuration"
  value       = module.test_resource_group.resource_summary
}
