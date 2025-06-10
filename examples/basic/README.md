# Basic Example - Azure Resource Group Module

This example demonstrates the minimal configuration required to use the Azure Resource Group module.

## Configuration

```hcl
module "basic_rg" {
  source = "github.com/aj-geddes/terraform-module-demo-v2"

  name     = "example-basic-rg"
  location = "eastus"
}
```

## Usage

1. **Initialize Terraform**:
   ```bash
   terraform init
   ```

2. **Plan the deployment**:
   ```bash
   terraform plan
   ```

3. **Apply the configuration**:
   ```bash
   terraform apply
   ```

4. **Clean up resources**:
   ```bash
   terraform destroy
   ```

## Outputs

The basic example will create:
- A simple Azure Resource Group in East US region
- No additional security features (locks, RBAC, etc.)
- Default tags applied automatically by the module

## Expected Resources

- **Resource Group**: `example-basic-rg` in `eastus` region
- **Tags**: Automatic tags from module (terraform-managed, created-by, etc.)

## Customization

You can customize this basic example by:
- Changing the `name` to match your naming conventions
- Selecting a different Azure `location`
- Adding custom `tags` for your organization

## Next Steps

See the [advanced example](../advanced/) for more complex configurations including:
- Resource locks
- RBAC assignments
- Diagnostic settings
- Comprehensive tagging strategies
