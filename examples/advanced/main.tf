# Advanced Example - Production-Ready Azure Resource Group Configuration

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
}

# Data source for current client configuration
data "azurerm_client_config" "current" {}

# Example Log Analytics workspace (you may have an existing one)
resource "azurerm_log_analytics_workspace" "example" {
  name                = "law-${var.environment}-${var.project_name}"
  location            = var.location
  resource_group_name = "rg-monitoring-${var.environment}"  # Assuming this exists
  sku                 = "PerGB2018"
  retention_in_days   = 90

  # Note: This assumes you have a monitoring resource group
  # You may need to create this first or use an existing workspace
  
  tags = var.common_tags
}

# Production-ready Resource Group with full security features
module "secure_rg" {
  source = "github.com/aj-geddes/terraform-module-demo-v2"

  # Basic configuration
  name     = "rg-${var.project_name}-${var.environment}"
  location = var.location
  
  # Security and governance
  prevent_destroy       = var.environment == "production" ? true : false
  enable_resource_lock  = var.enable_resource_lock
  lock_level           = var.lock_level
  lock_notes           = "Critical ${var.environment} resource - contact ${var.owner_team} before changes"
  
  # RBAC assignments - customize these based on your organization
  role_assignments = var.role_assignments
  
  # Monitoring and compliance
  enable_diagnostic_settings     = var.enable_monitoring
  log_analytics_workspace_id     = var.enable_monitoring ? azurerm_log_analytics_workspace.example.id : null
  diagnostic_retention_days      = var.diagnostic_retention_days
  
  # Comprehensive tagging strategy
  tags = merge(var.common_tags, {
    Environment         = var.environment
    Application        = var.project_name
    Owner              = var.owner_team
    CostCenter         = var.cost_center
    Compliance         = var.compliance_framework
    BackupRequired     = var.backup_required
    DataClassification = var.data_classification
    MaintenanceWindow  = var.maintenance_window
    SupportLevel       = var.support_level
    CreatedBy          = "terraform-advanced-example"
    LastReviewed       = formatdate("YYYY-MM-DD", timestamp())
  })

  depends_on = [azurerm_log_analytics_workspace.example]
}

# Example of using the resource group in other resources
resource "azurerm_storage_account" "example" {
  count = var.create_sample_resources ? 1 : 0

  name                     = "st${replace(var.project_name, "-", "")}${var.environment}001"
  resource_group_name      = module.secure_rg.name
  location                = module.secure_rg.location
  account_tier            = "Standard"
  account_replication_type = var.environment == "production" ? "GRS" : "LRS"
  
  # Enable security features
  enable_https_traffic_only      = true
  min_tls_version               = "TLS1_2"
  allow_nested_items_to_be_public = false
  
  # Inherit tags from resource group
  tags = module.secure_rg.effective_tags
}

# Example Key Vault using the resource group
resource "azurerm_key_vault" "example" {
  count = var.create_sample_resources ? 1 : 0

  name                = "kv-${var.project_name}-${var.environment}"
  location            = module.secure_rg.location
  resource_group_name = module.secure_rg.name
  tenant_id          = data.azurerm_client_config.current.tenant_id
  sku_name           = "standard"

  # Security settings
  enabled_for_disk_encryption     = true
  enabled_for_template_deployment = true
  purge_protection_enabled       = var.environment == "production" ? true : false
  soft_delete_retention_days     = 7

  # Network access
  network_acls {
    default_action = "Deny"
    bypass         = "AzureServices"
  }

  tags = module.secure_rg.effective_tags
}
