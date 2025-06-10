# Test variables for Terry
# These values will be used when running the Terraform plan

name     = "terry-test-resource-group"
location = "eastus"

tags = {
  Environment = "test"
  Purpose     = "validation"
  ManagedBy   = "terry"
  Project     = "terraform-module-demo-v2"
}

enable_resource_lock = true
lock_level           = "CanNotDelete"
lock_notes           = "Managed by Terry test - do not delete"

role_assignments = {
  reader = {
    role_definition_name = "Reader"
    principal_id         = "00000000-0000-0000-0000-000000000000"
    description          = "Terry test reader role"
  }
}
