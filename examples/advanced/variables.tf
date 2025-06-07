# Advanced Example Variables

variable "project_name" {
  description = "Name of the project or application"
  type        = string
  default     = "example-app"
  
  validation {
    condition     = can(regex("^[a-z0-9-]{3,20}$", var.project_name))
    error_message = "Project name must be 3-20 characters, lowercase alphanumeric and hyphens only."
  }
}

variable "environment" {
  description = "Environment name (dev, staging, prod)"
  type        = string
  default     = "dev"
  
  validation {
    condition     = contains(["dev", "test", "staging", "prod", "production"], var.environment)
    error_message = "Environment must be one of: dev, test, staging, prod, production."
  }
}

variable "location" {
  description = "Azure region for resources"
  type        = string
  default     = "eastus2"
}

variable "owner_team" {
  description = "Team responsible for the resources"
  type        = string
  default     = "platform-team@company.com"
}

variable "cost_center" {
  description = "Cost center for billing allocation"
  type        = string
  default     = "IT-001"
}

variable "compliance_framework" {
  description = "Compliance framework (SOC2, ISO27001, PCI-DSS, etc.)"
  type        = string
  default     = "SOC2"
}

variable "backup_required" {
  description = "Whether backup is required for resources in this RG"
  type        = string
  default     = "true"
  
  validation {
    condition     = contains(["true", "false"], var.backup_required)
    error_message = "Backup required must be 'true' or 'false'."
  }
}

variable "data_classification" {
  description = "Data classification level"
  type        = string
  default     = "internal"
  
  validation {
    condition     = contains(["public", "internal", "confidential", "restricted"], var.data_classification)
    error_message = "Data classification must be one of: public, internal, confidential, restricted."
  }
}

variable "maintenance_window" {
  description = "Maintenance window for resources"
  type        = string
  default     = "Sunday 02:00-04:00 UTC"
}

variable "support_level" {
  description = "Support level for resources"
  type        = string
  default     = "standard"
  
  validation {
    condition     = contains(["basic", "standard", "premium", "critical"], var.support_level)
    error_message = "Support level must be one of: basic, standard, premium, critical."
  }
}

# Security and governance variables
variable "enable_resource_lock" {
  description = "Enable resource lock on the resource group"
  type        = bool
  default     = true
}

variable "lock_level" {
  description = "Level of resource lock"
  type        = string
  default     = "CanNotDelete"
  
  validation {
    condition     = contains(["CanNotDelete", "ReadOnly"], var.lock_level)
    error_message = "Lock level must be either 'CanNotDelete' or 'ReadOnly'."
  }
}

# Monitoring variables
variable "enable_monitoring" {
  description = "Enable diagnostic settings and monitoring"
  type        = bool
  default     = true
}

variable "diagnostic_retention_days" {
  description = "Number of days to retain diagnostic logs"
  type        = number
  default     = 90
  
  validation {
    condition     = var.diagnostic_retention_days >= 30 && var.diagnostic_retention_days <= 365
    error_message = "Diagnostic retention must be between 30 and 365 days for production use."
  }
}

# RBAC configuration
variable "role_assignments" {
  description = "RBAC role assignments for the resource group"
  type = map(object({
    role_definition_name = string
    principal_id         = string
    description          = optional(string, "Managed by Terraform")
  }))
  default = {
    # Example assignments - customize for your organization
    platform_team = {
      role_definition_name = "Contributor"
      principal_id         = "00000000-0000-0000-0000-000000000000"  # Replace with actual ID
      description          = "Platform team contributor access"
    }
    security_team = {
      role_definition_name = "Reader"
      principal_id         = "11111111-1111-1111-1111-111111111111"  # Replace with actual ID
      description          = "Security team read access for compliance"
    }
  }
}

# Sample resources toggle
variable "create_sample_resources" {
  description = "Whether to create sample resources (Storage Account, Key Vault) to demonstrate usage"
  type        = bool
  default     = false
}

# Common tags that will be merged with module tags
variable "common_tags" {
  description = "Common tags to apply to all resources"
  type        = map(string)
  default = {
    ManagedBy       = "terraform"
    Repository      = "terraform-module-demo-v2"
    Example         = "advanced"
    DeploymentDate  = ""  # Will be populated at runtime
  }
}
