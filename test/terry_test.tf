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

# Configure the Azure Provider
provider "azurerm" {
  features {}
  # Authentication will use variables passed to Terry
}

provider "azuread" {
  # Authentication will use variables passed to Terry
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
