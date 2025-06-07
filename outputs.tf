# Azure Resource Group Terraform Module Outputs
# Comprehensive outputs for downstream modules and consumers

output "id" {
  description = "The ID of the Azure Resource Group. Use this for referencing the resource group in other modules or resources."
  value       = azurerm_resource_group.this.id
}

output "name" {
  description = "The name of the Azure Resource Group. Useful for resource naming conventions and referencing."
  value       = azurerm_resource_group.this.name
}

output "location" {
  description = "The Azure region where the Resource Group is located. Use this to ensure resources are created in the same region."
  value       = azurerm_resource_group.this.location
}

output "tags" {
  description = "The tags assigned to the Azure Resource Group. Useful for propagating tags to child resources."
  value       = azurerm_resource_group.this.tags
}

output "management_lock_id" {
  description = "The ID of the management lock (if enabled). Use this to reference or manage the lock in other configurations."
  value       = var.enable_resource_lock ? azurerm_management_lock.this[0].id : null
}

output "management_lock_level" {
  description = "The level of the management lock (if enabled). Indicates the type of protection applied to the resource group."
  value       = var.enable_resource_lock ? azurerm_management_lock.this[0].lock_level : null
}

output "role_assignment_ids" {
  description = "Map of role assignment IDs created on the Resource Group. Useful for tracking and managing RBAC assignments."
  value = {
    for k, v in azurerm_role_assignment.this : k => v.id
  }
}

output "subscription_id" {
  description = "The Azure Subscription ID where the Resource Group is created. Useful for constructing resource ARNs."
  value       = data.azurerm_client_config.current.subscription_id
}

output "tenant_id" {
  description = "The Azure Tenant ID associated with the subscription. Useful for identity and access management configurations."
  value       = data.azurerm_client_config.current.tenant_id
}

output "resource_group_arn" {
  description = "The Azure Resource Manager ARN of the Resource Group. Fully qualified resource identifier for external integrations."
  value       = "/subscriptions/${data.azurerm_client_config.current.subscription_id}/resourceGroups/${azurerm_resource_group.this.name}"
}

# Sensitive outputs for security-related information
output "client_config" {
  description = "Current Azure client configuration details. Contains sensitive authentication information."
  value = {
    client_id       = data.azurerm_client_config.current.client_id
    subscription_id = data.azurerm_client_config.current.subscription_id
    tenant_id       = data.azurerm_client_config.current.tenant_id
    object_id       = data.azurerm_client_config.current.object_id
  }
  sensitive = true
}

# Outputs for policy and compliance
output "created_timestamp" {
  description = "Timestamp when the Resource Group was created (RFC3339 format). Useful for compliance and auditing."
  value       = timestamp()
}

output "terraform_workspace" {
  description = "The Terraform workspace used to create this Resource Group. Useful for environment tracking."
  value       = terraform.workspace
}

# Outputs for monitoring and observability
output "activity_log_enabled" {
  description = "Whether diagnostic settings are enabled for activity logs. Indicates monitoring readiness."
  value       = var.enable_diagnostic_settings
}

output "log_analytics_workspace_id" {
  description = "The Log Analytics workspace ID used for diagnostic settings (if configured). Useful for centralized logging setup."
  value       = var.enable_diagnostic_settings ? var.log_analytics_workspace_id : null
}

# Output for tagging and governance
output "effective_tags" {
  description = "All effective tags on the Resource Group including any default tags. Shows the complete tagging strategy applied."
  value = merge(
    var.tags,
    {
      "terraform-managed" = "true"
      "created-by"        = "terraform-module-demo-v2"
      "last-modified"     = timestamp()
    }
  )
}

# Resource configuration summary
output "resource_summary" {
  description = "Summary of the Resource Group configuration including security and compliance features."
  value = {
    name                      = azurerm_resource_group.this.name
    location                  = azurerm_resource_group.this.location
    tag_count                 = length(var.tags)
    prevent_destroy_enabled   = var.prevent_destroy
    resource_lock_enabled     = var.enable_resource_lock
    lock_level               = var.enable_resource_lock ? var.lock_level : null
    rbac_assignments_count   = length(var.role_assignments)
    diagnostic_logs_enabled  = var.enable_diagnostic_settings
    retention_days          = var.enable_diagnostic_settings ? var.diagnostic_retention_days : null
  }
}
