# Azure Resource Group Terraform Module
# Creates an Azure Resource Group with optional management lock and RBAC capabilities

# Create the Resource Group
resource "azurerm_resource_group" "this" {
  name     = var.name
  location = var.location
  tags     = var.tags

  # Lifecycle block for production environments
  # To prevent destruction, uncomment and set to true
  # lifecycle {
  #   prevent_destroy = true
  # }
}

# Optional Management Lock
resource "azurerm_management_lock" "this" {
  count = var.enable_resource_lock ? 1 : 0

  name       = "${var.name}-lock"
  scope      = azurerm_resource_group.this.id
  lock_level = var.lock_level
  notes      = var.lock_notes

  depends_on = [azurerm_resource_group.this]
}

# Optional Role Assignment for RBAC
resource "azurerm_role_assignment" "this" {
  for_each = var.role_assignments

  scope                = azurerm_resource_group.this.id
  role_definition_name = each.value.role_definition_name
  principal_id         = each.value.principal_id
  description          = each.value.description

  depends_on = [azurerm_resource_group.this]
}

# Data source for current Azure client configuration
data "azuread_client_config" "current" {}

# Data source for subscription information
data "azurerm_client_config" "current" {}
