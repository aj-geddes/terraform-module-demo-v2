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

# Configure the Azure Provider - will use environment variables for authentication
provider "azurerm" {
  features {}
  # Authentication will use ARM_* environment variables
}

provider "azuread" {
  # Authentication will use ARM_* environment variables 
}

# Module configuration for testing
module "test_resource_group" {
  source = "./.."

  name     = "terry-test-rg"
  location = "eastus"

  tags = {
    Environment = "test"
    Project     = "terraform-module-demo"
    ManagedBy   = "terraform"
    CreatedBy   = "service-principal"
  }

  # Resource lock configuration
  enable_resource_lock = true
  lock_level           = "CanNotDelete"
  lock_notes           = "Protected resource group - managed by Terraform"
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
