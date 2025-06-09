# Azure Resource Group Terraform Module Variables
# Comprehensive input validation and configuration options

variable "name" {
  description = "The name of the Azure Resource Group. Must be 1-90 characters long, can contain alphanumeric characters, periods, underscores, hyphens, and parentheses. Cannot end with a period."
  type        = string

  validation {
    condition = can(regex("^[a-zA-Z0-9.\\(\\)-]{1,90}$", var.name)) && !can(regex("\\.$", var.name))
    error_message = "Resource Group name must be 1-90 characters long, contain only alphanumeric characters, periods, underscores, hyphens, and parentheses, and cannot end with a period."
  }
}

variable "location" {
  description = "The Azure region where the Resource Group will be created. Must be a valid Azure region name."
  type        = string

  validation {
    condition = contains([
      "australiacentral", "australiacentral2", "australiaeast", "australiasoutheast",
      "brazilsouth", "brazilsoutheast", "canadacentral", "canadaeast",
      "centralindia", "centralus", "centraluseuap", "eastasia", "eastus", "eastus2",
      "eastus2euap", "francecentral", "francesouth", "germanynorth", "germanywestcentral",
      "japaneast", "japanwest", "jioindiacentral", "jioindiawest", "koreacentral", "koreasouth",
      "northcentralus", "northeurope", "norwayeast", "norwaywest", "polandcentral",
      "qatarcentral", "southafricanorth", "southafricawest", "southcentralus", "southeastasia",
      "southindia", "swedencentral", "switzerlandnorth", "switzerlandwest", "uaecentral", "uaenorth",
      "uksouth", "ukwest", "westcentralus", "westeurope", "westindia", "westus", "westus2", "westus3"
    ], var.location)
    error_message = "Location must be a valid Azure region. Common regions include: eastus, westus2, centralus, westeurope, northeurope, southeastasia, eastasia, etc."
  }
}

variable "tags" {
  description = "A mapping of tags to assign to the Resource Group. Maximum of 50 tags allowed, with key length ≤ 512 characters and value length ≤ 256 characters."
  type        = map(string)
  default     = {}

  validation {
    condition     = length(var.tags) <= 50
    error_message = "Maximum of 50 tags are allowed per Resource Group."
  }

  validation {
    condition = alltrue([
      for k, v in var.tags : length(k) <= 512 && length(v) <= 256
    ])
    error_message = "Tag keys must be ≤ 512 characters and tag values must be ≤ 256 characters."
  }

  validation {
    condition = alltrue([
      for k, v in var.tags : !contains(["microsoft", "azure", "windows"], lower(k))
    ])
    error_message = "Tag keys cannot use reserved prefixes: microsoft, azure, windows."
  }
}

variable "prevent_destroy" {
  description = "Prevents Terraform from destroying the Resource Group. Useful for production environments to avoid accidental deletion."
  type        = bool
  default     = false
}

variable "enable_resource_lock" {
  description = "Enable Azure Resource Manager lock on the Resource Group to prevent accidental deletion or modification."
  type        = bool
  default     = false
}

variable "lock_level" {
  description = "Level of the Resource Manager lock. Possible values are CanNotDelete and ReadOnly."
  type        = string
  default     = "CanNotDelete"

  validation {
    condition     = contains(["CanNotDelete", "ReadOnly"], var.lock_level)
    error_message = "Lock level must be either 'CanNotDelete' or 'ReadOnly'."
  }
}

variable "lock_notes" {
  description = "Notes about the Resource Manager lock."
  type        = string
  default     = "Managed by Terraform - prevents accidental deletion"

  validation {
    condition     = length(var.lock_notes) <= 512
    error_message = "Lock notes must be ≤ 512 characters."
  }
}

variable "role_assignments" {
  description = "Map of RBAC role assignments to create on the Resource Group. Each assignment requires role_definition_name, principal_id, and optional description."
  type = map(object({
    role_definition_name = string
    principal_id         = string
    description          = optional(string, "Managed by Terraform")
  }))
  default = {}

  validation {
    condition = alltrue([
      for k, v in var.role_assignments : contains([
        "Owner", "Contributor", "Reader", "User Access Administrator",
        "Storage Blob Data Owner", "Storage Blob Data Contributor", "Storage Blob Data Reader",
        "Key Vault Administrator", "Key Vault Secrets Officer", "Key Vault Secrets User",
        "Network Contributor", "Security Admin", "Security Reader", "Monitoring Contributor", "Monitoring Reader"
      ], v.role_definition_name)
    ])
    error_message = "Role definition name must be a valid Azure built-in role."
  }
}

variable "enable_diagnostic_settings" {
  description = "Enable diagnostic settings for the Resource Group to send activity logs to Log Analytics workspace or Storage Account."
  type        = bool
  default     = false
}

variable "log_analytics_workspace_id" {
  description = "The ID of the Log Analytics workspace to send diagnostic logs to. Required if enable_diagnostic_settings is true."
  type        = string
  default     = null

  # Note: Cross-variable validation is not possible in current Terraform versions
  # Validation will be performed in the module logic instead
}

variable "diagnostic_retention_days" {
  description = "Number of days to retain diagnostic logs. Must be between 0 and 365 days."
  type        = number
  default     = 30

  validation {
    condition     = var.diagnostic_retention_days >= 0 && var.diagnostic_retention_days <= 365
    error_message = "Diagnostic retention days must be between 0 and 365."
  }
}