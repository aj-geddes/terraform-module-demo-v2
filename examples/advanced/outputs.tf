# Advanced Example Outputs

output "resource_group_id" {
  description = "The ID of the created resource group"
  value       = module.secure_rg.id
}

output "resource_group_name" {
  description = "The name of the created resource group"
  value       = module.secure_rg.name
}

output "resource_group_location" {
  description = "The location of the created resource group"
  value       = module.secure_rg.location
}

output "resource_group_arn" {
  description = "The Azure Resource Manager ARN of the resource group"
  value       = module.secure_rg.resource_group_arn
}

# Security and governance outputs
output "management_lock_id" {
  description = "The ID of the management lock (if enabled)"
  value       = module.secure_rg.management_lock_id
}

output "management_lock_level" {
  description = "The level of the management lock (if enabled)"
  value       = module.secure_rg.management_lock_level
}

output "role_assignment_ids" {
  description = "Map of role assignment IDs created on the resource group"
  value       = module.secure_rg.role_assignment_ids
}

# Monitoring and compliance outputs
output "activity_log_enabled" {
  description = "Whether diagnostic settings are enabled for activity logs"
  value       = module.secure_rg.activity_log_enabled
}

output "log_analytics_workspace_id" {
  description = "The Log Analytics workspace ID used for diagnostic settings"
  value       = module.secure_rg.log_analytics_workspace_id
}

# Tagging and governance outputs
output "effective_tags" {
  description = "All effective tags applied to the resource group"
  value       = module.secure_rg.effective_tags
}

output "resource_summary" {
  description = "Summary of the resource group configuration"
  value       = module.secure_rg.resource_summary
}

# Azure context outputs
output "subscription_id" {
  description = "The Azure subscription ID where resources are created"
  value       = module.secure_rg.subscription_id
}

output "tenant_id" {
  description = "The Azure tenant ID associated with the subscription"
  value       = module.secure_rg.tenant_id
}

output "terraform_workspace" {
  description = "The Terraform workspace used to create resources"
  value       = module.secure_rg.terraform_workspace
}

# Sample resource outputs (if created)
output "storage_account_id" {
  description = "The ID of the sample storage account (if created)"
  value       = var.create_sample_resources ? azurerm_storage_account.example[0].id : null
}

output "storage_account_name" {
  description = "The name of the sample storage account (if created)"
  value       = var.create_sample_resources ? azurerm_storage_account.example[0].name : null
}

output "key_vault_id" {
  description = "The ID of the sample key vault (if created)"
  value       = var.create_sample_resources ? azurerm_key_vault.example[0].id : null
}

output "key_vault_uri" {
  description = "The URI of the sample key vault (if created)"
  value       = var.create_sample_resources ? azurerm_key_vault.example[0].vault_uri : null
}

# Configuration summary for documentation
output "configuration_summary" {
  description = "Summary of the advanced configuration applied"
  value = {
    project_name              = var.project_name
    environment              = var.environment
    location                 = var.location
    resource_lock_enabled    = var.enable_resource_lock
    lock_level              = var.lock_level
    monitoring_enabled      = var.enable_monitoring
    diagnostic_retention    = var.diagnostic_retention_days
    rbac_assignments_count  = length(var.role_assignments)
    sample_resources_created = var.create_sample_resources
    compliance_framework    = var.compliance_framework
    data_classification     = var.data_classification
    support_level          = var.support_level
  }
}

# Sensitive outputs (marked appropriately)
output "client_config" {
  description = "Current Azure client configuration details"
  value       = module.secure_rg.client_config
  sensitive   = true
}
