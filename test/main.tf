# Configure the AzureAD Provider with mock values
provider "azuread" {
  tenant_id     = "00000000-0000-0000-0000-000000000000"
  client_id     = "00000000-0000-0000-0000-000000000000"
  client_secret = "mock-client-secret"
}
# Test configuration for Terraform Module Demo
# Used with Terry to validate module functionality

terraform {
  required_version = ">= 1.5.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.0"
    }
  }
}

# Configure the Azure Provider
provider "azurerm" {
  # Mock values for testing with Terry
  features {}
  skip_provider_registration = true
  subscription_id           = "00000000-0000-0000-0000-000000000000"
  tenant_id                 = "00000000-0000-0000-0000-000000000000"
  client_id                 = "00000000-0000-0000-0000-000000000000"
  client_secret             = "mock-client-secret"
}

# Module configuration for testing
module "test_resource_group" {
  source = "./.."

  name     = "terry-test-rg"
  location = "eastus"

  # Tags for testing
  tags = {
    Environment = "test"
    Purpose     = "validation"
    ManagedBy   = "terry"
  }

  # Enable resource lock for testing
  enable_resource_lock = true
  lock_level           = "CanNotDelete"

  # Role assignments for testing
  role_assignments = {
    reader = {
      role_definition_name = "Reader"
      principal_id         = "00000000-0000-0000-0000-000000000000" # Placeholder ID
      description          = "Test Reader Role Assignment"
    }
  }
}

# Output the resource group information
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
  description = "All effective tags applied to the resource group"
  value       = module.test_resource_group.effective_tags
}

output "resource_summary" {
  description = "Summary of the resource group configuration"
  value       = module.test_resource_group.resource_summary
}
