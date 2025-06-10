# Terraform and Provider Requirements
# Separate file for better organization and clarity

terraform {
  required_version = ">= 1.5.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.0, < 5.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = ">= 2.0"
    }
  }

  # Optional: Configure backend for state management
  # Uncomment and configure based on your requirements
  # backend "azurerm" {
  #   resource_group_name  = "terraform-state-rg"
  #   storage_account_name = "terraformstatestorage"
  #   container_name       = "tfstate"
  #   key                  = "terraform.tfstate"
  # }
}

# Experimental features (if needed)
# terraform {
#   experiments = [module_variable_optional_attrs]
# }
