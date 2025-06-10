# Basic Example - Minimal Azure Resource Group Configuration

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
  features {}
}

# Basic Resource Group module usage
module "basic_rg" {
  source = "github.com/aj-geddes/terraform-module-demo-v2"

  name     = "example-basic-rg"
  location = "eastus"
  
  # Optional: Add basic tags
  tags = {
    Environment = "development"
    Purpose     = "testing"
    Owner       = "platform-team"
  }
}

# Output the resource group information
output "resource_group_id" {
  description = "The ID of the created resource group"
  value       = module.basic_rg.id
}

output "resource_group_name" {
  description = "The name of the created resource group"
  value       = module.basic_rg.name
}

output "resource_group_location" {
  description = "The location of the created resource group"
  value       = module.basic_rg.location
}

output "effective_tags" {
  description = "All effective tags applied to the resource group"
  value       = module.basic_rg.effective_tags
}
