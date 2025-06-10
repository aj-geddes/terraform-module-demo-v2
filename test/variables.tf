# Authentication variables
variable "subscription_id" {
  description = "The Azure Subscription ID to deploy resources to"
  type        = string
  sensitive   = true
}

variable "tenant_id" {
  description = "The Azure AD Tenant ID"
  type        = string
  sensitive   = true
}

variable "client_id" {
  description = "The Service Principal App ID (Client ID)"
  type        = string
  sensitive   = true
}

variable "client_secret" {
  description = "The Service Principal Client Secret"
  type        = string
  sensitive   = true
}

# Resource Group variables
variable "name" {
  description = "The name of the Azure Resource Group"
  type        = string
}

variable "location" {
  description = "The Azure region where the Resource Group will be created"
  type        = string
}

variable "tags" {
  description = "A mapping of tags to assign to the Resource Group"
  type        = map(string)
  default     = {}
}

variable "enable_resource_lock" {
  description = "Enable Azure Resource Manager lock on the Resource Group"
  type        = bool
  default     = false
}

variable "lock_level" {
  description = "Level of the Resource Manager lock (CanNotDelete or ReadOnly)"
  type        = string
  default     = "CanNotDelete"
}

variable "lock_notes" {
  description = "Notes about the Resource Manager lock"
  type        = string
  default     = "Managed by Terraform - prevents accidental deletion"
}

variable "role_assignments" {
  description = "Map of RBAC role assignments to create on the Resource Group"
  type = map(object({
    role_definition_name = string
    principal_id         = string
    description          = optional(string, "Managed by Terraform")
  }))
  default = {}
}
