# Configure the Azure Providers using environment variables
provider "azurerm" {
  features {}
  # Authentication will use ARM_* environment variables
}

provider "azuread" {
  # Authentication will use ARM_* environment variables
}
