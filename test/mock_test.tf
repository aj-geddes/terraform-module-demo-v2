# Configure the module with values that can be mocked easily

terraform {
  required_version = ">= 1.5.0"
}

# Configure the Azure Resource Group module using variables
module "azure_resource_group" {
  source = "./.."

  # Required parameters
  name     = "mock-test-rg"
  location = "eastus"

  # Optional parameters with default values
  tags = {
    Environment = "test"
    Project     = "terraform-module-demo"
    ManagedBy   = "terry"
  }

  # Security features
  enable_resource_lock = true
  lock_level           = "CanNotDelete"
  lock_notes           = "Protected resource group - managed by Terraform"

  # Role assignments
  role_assignments = {
    reader = {
      role_definition_name = "Reader"
      principal_id         = "00000000-0000-0000-0000-000000000000"
      description          = "Test reader role"
    }
  }
}

# Output relevant resource information
output "resource_group_id" {
  description = "The ID of the created resource group"
  value       = module.azure_resource_group.id
}

output "resource_group_name" {
  description = "The name of the created resource group"
  value       = module.azure_resource_group.name
}

output "effective_tags" {
  description = "All tags applied to the resource group"
  value       = module.azure_resource_group.effective_tags
}
