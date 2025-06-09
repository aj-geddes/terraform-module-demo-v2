# Test configuration for Terraform Module Demo
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

# Configure the Azure Provider to use Azure CLI authentication
provider "azurerm" {
  features {}
  # When no credentials are provided, it will use the Azure CLI authentication
}

# Configure the AzureAD Provider to use Azure CLI authentication
provider "azuread" {
  # When no credentials are provided, it will use the Azure CLI authentication
}

# Module configuration for testing
module "test_resource_group" {
  source = "./.."

  # Required parameters
  name     = "terraform-demo-rg"
  location = "eastus"

  # Optional parameters with default values
  tags = {
    Environment = "development"
    Project     = "terraform-module-demo"
    ManagedBy   = "terraform"
    CreatedBy   = "your-name"
  }

  # Security features
  enable_resource_lock = true
  lock_level           = "CanNotDelete"
  lock_notes           = "Protected resource group - managed by Terraform"

  # Role assignments - add your own user/group objectId if desired
  # role_assignments = {
  #   reader = {
  #     role_definition_name = "Reader"
  #     principal_id         = "your-azure-ad-user-or-group-id"
  #     description          = "Reader role for development team"
  #   }
  # }
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
