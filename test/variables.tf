# Resource Group variables - these don't need to include auth variables anymore
# since we're using environment variables

# Resource Group variables
variable "name" {
  description = "The name of the Azure Resource Group"
  type        = string
  default     = "test-resource-group"
}

variable "location" {
  description = "The Azure region where the Resource Group will be created"
  type        = string
  default     = "eastus"
}

variable "tags" {
  description = "A mapping of tags to assign to the Resource Group"
  type        = map(string)
  default     = {
    Environment = "test"
    Project     = "terraform-module-demo"
    ManagedBy   = "terraform"
    CreatedBy   = "service-principal"
  }
}

variable "enable_resource_lock" {
  description = "Enable Azure Resource Manager lock on the Resource Group"
  type        = bool
  default     = true
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
