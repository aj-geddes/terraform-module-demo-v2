# Azure Resource Group Terraform Module v2

[![Terraform](https://img.shields.io/badge/terraform-%23623CE4.svg?style=for-the-badge&logo=terraform&logoColor=white)](https://www.terraform.io/)
[![Azure](https://img.shields.io/badge/azure-%230072C6.svg?style=for-the-badge&logo=microsoftazure&logoColor=white)](https://azure.microsoft.com/)
[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg?style=for-the-badge)](https://opensource.org/licenses/Apache-2.0)

Production-ready, reusable Terraform module for creating Azure Resource Groups with comprehensive validation, security features, and enterprise-grade capabilities.

## Features

🔒 **Security & Compliance**
- Resource locks to prevent accidental deletion
- RBAC role assignments with validation
- Comprehensive input validation
- Sensitive output handling

📊 **Monitoring & Observability**
- Diagnostic settings integration
- Activity log configuration
- Audit trail support

🏷️ **Governance & Tagging**
- Advanced tag validation and limits
- Automatic tagging with creation metadata
- Organizational tag standards enforcement

⚡ **Production Ready**
- Terraform >= 1.5.0 support
- Azure Provider >= 3.0 compatibility
- Comprehensive validation rules
- Detailed documentation

## Quick Start

```hcl
module "resource_group" {
  source = "github.com/aj-geddes/terraform-module-demo-v2"

  name     = "my-production-rg"
  location = "eastus2"
  
  tags = {
    Environment = "production"
    Owner       = "platform-team"
    Project     = "azure-infrastructure"
  }
}
```

## Usage Examples

### Basic Usage

```hcl
module "basic_rg" {
  source = "github.com/aj-geddes/terraform-module-demo-v2"

  name     = "my-app-rg"
  location = "eastus"
}
```

### Advanced Usage with Security Features

```hcl
module "secure_rg" {
  source = "github.com/aj-geddes/terraform-module-demo-v2"

  name     = "critical-workload-rg"
  location = "eastus2"
  
  # Security and governance
  prevent_destroy       = true
  enable_resource_lock  = true
  lock_level           = "CanNotDelete"
  lock_notes           = "Critical production resource - contact platform team before changes"
  
  # RBAC assignments
  role_assignments = {
    platform_team = {
      role_definition_name = "Contributor"
      principal_id         = "12345678-1234-1234-1234-123456789012"
      description          = "Platform team contributor access"
    }
    security_team = {
      role_definition_name = "Reader"
      principal_id         = "87654321-4321-4321-4321-210987654321"
      description          = "Security team read access for compliance"
    }
  }
  
  # Monitoring and compliance
  enable_diagnostic_settings     = true
  log_analytics_workspace_id     = "/subscriptions/sub-id/resourceGroups/monitoring-rg/providers/Microsoft.OperationalInsights/workspaces/central-logs"
  diagnostic_retention_days      = 90
  
  # Comprehensive tagging
  tags = {
    Environment     = "production"
    Application     = "core-services"
    Owner          = "platform-team@company.com"
    CostCenter     = "IT-001"
    Compliance     = "SOC2"
    BackupRequired = "true"
    DataClass      = "confidential"
  }
}
```

### Multi-Environment Pattern

```hcl
# Development environment
module "dev_rg" {
  source = "github.com/aj-geddes/terraform-module-demo-v2"

  name     = "myapp-dev-rg"
  location = "eastus"
  
  tags = {
    Environment = "development"
    Owner       = "dev-team"
    AutoShutdown = "true"
  }
}

# Production environment with full security
module "prod_rg" {
  source = "github.com/aj-geddes/terraform-module-demo-v2"

  name                = "myapp-prod-rg"
  location            = "eastus2"
  prevent_destroy     = true
  enable_resource_lock = true
  
  tags = {
    Environment = "production"
    Owner       = "ops-team"
    Criticality = "high"
  }
}

# Reference outputs in other resources
resource "azurerm_storage_account" "example" {
  name                     = "examplestorageacct"
  resource_group_name      = module.prod_rg.name
  location                = module.prod_rg.location
  account_tier            = "Standard"
  account_replication_type = "LRS"
  
  tags = module.prod_rg.effective_tags
}
```

## Validation Rules

### Resource Group Name
- **Length**: 1-90 characters
- **Characters**: Alphanumeric, periods, underscores, hyphens, parentheses
- **Restrictions**: Cannot end with a period
- **Example**: `my-app-rg`, `production.workload_01`, `team(alpha)-resources`

### Location
- **Validation**: Must be a valid Azure region
- **Common Regions**: `eastus`, `westus2`, `centralus`, `westeurope`, `northeurope`, `southeastasia`
- **Error Guidance**: Provides helpful region suggestions on validation failure

### Tags
- **Limit**: Maximum 50 tags per resource group
- **Key Length**: ≤ 512 characters
- **Value Length**: ≤ 256 characters
- **Reserved Prefixes**: Cannot use `microsoft`, `azure`, `windows` as tag key prefixes

### RBAC Roles
- **Supported Roles**: Built-in Azure roles including Owner, Contributor, Reader, Security Admin, etc.
- **Principal ID**: Valid Azure AD object ID required
- **Validation**: Ensures role definition names are valid Azure built-in roles

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.0 |
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | >= 2.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 3.0, < 5.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azuread"></a> [azuread](#provider\_azuread) | >= 2.0 |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >= 3.0, < 5.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_management_lock.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/management_lock) | resource |
| [azurerm_resource_group.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_role_assignment.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azuread_client_config.current](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/client_config) | data source |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_location"></a> [location](#input\_location) | The Azure region where the Resource Group will be created. Must be a valid Azure region name. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The name of the Azure Resource Group. Must be 1-90 characters long, can contain alphanumeric characters, periods, underscores, hyphens, and parentheses. Cannot end with a period. | `string` | n/a | yes |
| <a name="input_diagnostic_retention_days"></a> [diagnostic\_retention\_days](#input\_diagnostic\_retention\_days) | Number of days to retain diagnostic logs. Must be between 0 and 365 days. | `number` | `30` | no |
| <a name="input_enable_diagnostic_settings"></a> [enable\_diagnostic\_settings](#input\_enable\_diagnostic\_settings) | Enable diagnostic settings for the Resource Group to send activity logs to Log Analytics workspace or Storage Account. | `bool` | `false` | no |
| <a name="input_enable_resource_lock"></a> [enable\_resource\_lock](#input\_enable\_resource\_lock) | Enable Azure Resource Manager lock on the Resource Group to prevent accidental deletion or modification. | `bool` | `false` | no |
| <a name="input_lock_level"></a> [lock\_level](#input\_lock\_level) | Level of the Resource Manager lock. Possible values are CanNotDelete and ReadOnly. | `string` | `"CanNotDelete"` | no |
| <a name="input_lock_notes"></a> [lock\_notes](#input\_lock\_notes) | Notes about the Resource Manager lock. | `string` | `"Managed by Terraform - prevents accidental deletion"` | no |
| <a name="input_log_analytics_workspace_id"></a> [log\_analytics\_workspace\_id](#input\_log\_analytics\_workspace\_id) | The ID of the Log Analytics workspace to send diagnostic logs to. Required if enable\_diagnostic\_settings is true. | `string` | `null` | no |
| <a name="input_prevent_destroy"></a> [prevent\_destroy](#input\_prevent\_destroy) | Prevents Terraform from destroying the Resource Group. Useful for production environments to avoid accidental deletion. | `bool` | `false` | no |
| <a name="input_role_assignments"></a> [role\_assignments](#input\_role\_assignments) | Map of RBAC role assignments to create on the Resource Group. Each assignment requires role\_definition\_name, principal\_id, and optional description. | <pre>map(object({<br>    role_definition_name = string<br>    principal_id         = string<br>    description          = optional(string, "Managed by Terraform")<br>  }))</pre> | `{}` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A mapping of tags to assign to the Resource Group. Maximum of 50 tags allowed, with key length ≤ 512 characters and value length ≤ 256 characters. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_activity_log_enabled"></a> [activity\_log\_enabled](#output\_activity\_log\_enabled) | Whether diagnostic settings are enabled for activity logs. Indicates monitoring readiness. |
| <a name="output_client_config"></a> [client\_config](#output\_client\_config) | Current Azure client configuration details. Contains sensitive authentication information. |
| <a name="output_created_timestamp"></a> [created\_timestamp](#output\_created\_timestamp) | Timestamp when the Resource Group was created (RFC3339 format). Useful for compliance and auditing. |
| <a name="output_effective_tags"></a> [effective\_tags](#output\_effective\_tags) | All effective tags on the Resource Group including any default tags. Shows the complete tagging strategy applied. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the Azure Resource Group. Use this for referencing the resource group in other modules or resources. |
| <a name="output_location"></a> [location](#output\_location) | The Azure region where the Resource Group is located. Use this to ensure resources are created in the same region. |
| <a name="output_log_analytics_workspace_id"></a> [log\_analytics\_workspace\_id](#output\_log\_analytics\_workspace\_id) | The Log Analytics workspace ID used for diagnostic settings (if configured). Useful for centralized logging setup. |
| <a name="output_management_lock_id"></a> [management\_lock\_id](#output\_management\_lock\_id) | The ID of the management lock (if enabled). Use this to reference or manage the lock in other configurations. |
| <a name="output_management_lock_level"></a> [management\_lock\_level](#output\_management\_lock\_level) | The level of the management lock (if enabled). Indicates the type of protection applied to the resource group. |
| <a name="output_name"></a> [name](#output\_name) | The name of the Azure Resource Group. Useful for resource naming conventions and referencing. |
| <a name="output_resource_group_arn"></a> [resource\_group\_arn](#output\_resource\_group\_arn) | The Azure Resource Manager ARN of the Resource Group. Fully qualified resource identifier for external integrations. |
| <a name="output_resource_summary"></a> [resource\_summary](#output\_resource\_summary) | Summary of the Resource Group configuration including security and compliance features. |
| <a name="output_role_assignment_ids"></a> [role\_assignment\_ids](#output\_role\_assignment\_ids) | Map of role assignment IDs created on the Resource Group. Useful for tracking and managing RBAC assignments. |
| <a name="output_subscription_id"></a> [subscription\_id](#output\_subscription\_id) | The Azure Subscription ID where the Resource Group is created. Useful for constructing resource ARNs. |
| <a name="output_tags"></a> [tags](#output\_tags) | The tags assigned to the Azure Resource Group. Useful for propagating tags to child resources. |
| <a name="output_tenant_id"></a> [tenant\_id](#output\_tenant\_id) | The Azure Tenant ID associated with the subscription. Useful for identity and access management configurations. |
| <a name="output_terraform_workspace"></a> [terraform\_workspace](#output\_terraform\_workspace) | The Terraform workspace used to create this Resource Group. Useful for environment tracking. |

## Development

### Prerequisites

- [Terraform](https://www.terraform.io/downloads.html) >= 1.5.0
- [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli) >= 2.40.0
- Valid Azure subscription with appropriate permissions
- [terraform-docs](https://terraform-docs.io/) (for documentation generation)

### Local Testing Workflow

```bash
# 1. Clone the repository
git clone https://github.com/aj-geddes/terraform-module-demo-v2.git
cd terraform-module-demo-v2

# 2. Authenticate with Azure
az login

# 3. Initialize Terraform
terraform init

# 4. Validate configuration
terraform validate

# 5. Format code
terraform fmt -recursive

# 6. Plan deployment (using examples)
cd examples/basic
terraform init
terraform plan

# 7. Apply (if desired)
terraform apply

# 8. Clean up
terraform destroy
```

### Testing Examples

The module includes comprehensive examples in the `examples/` directory:

- **basic/**: Minimal configuration for getting started
- **advanced/**: Full-featured implementation with all security options
- **multi-environment/**: Pattern for managing multiple environments

### Code Quality

This module follows Terraform best practices:

- ✅ Consistent formatting with `terraform fmt`
- ✅ Validation with `terraform validate`
- ✅ Comprehensive input validation
- ✅ Detailed documentation with terraform-docs
- ✅ Security-first approach with optional features
- ✅ Semantic versioning for releases

### Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Make your changes following the established patterns
4. Add tests for new functionality
5. Update documentation if needed
6. Commit your changes (`git commit -m 'Add amazing feature'`)
7. Push to the branch (`git push origin feature/amazing-feature`)
8. Open a Pull Request

### Version History

See [CHANGELOG.md](CHANGELOG.md) for detailed version history and breaking changes.

## Security & Compliance

### Security Features

- **Resource Locks**: Prevent accidental deletion or modification
- **RBAC Integration**: Fine-grained access control with built-in role validation
- **Input Validation**: Comprehensive validation to prevent misconfigurations
- **Sensitive Outputs**: Proper handling of sensitive authentication data
- **Audit Trail**: Timestamp tracking and workspace identification

### Compliance Considerations

- **SOC2**: Activity logging and access controls support compliance requirements
- **ISO 27001**: Resource governance and change management alignment
- **Azure Security Benchmark**: Follows Microsoft security recommendations
- **NIST**: Identity and access management best practices

### Security Reporting

If you discover a security vulnerability, please:

1. **Do NOT** open a public issue
2. Email security concerns to the repository maintainer
3. Include detailed information about the vulnerability
4. Allow time for assessment and remediation

## Support & Troubleshooting

### Common Issues

**Validation Errors**
```
Error: Resource Group name validation failed
```
- Check name length (1-90 characters)
- Verify allowed characters (alphanumeric, periods, underscores, hyphens, parentheses)
- Ensure name doesn't end with a period

**Location Errors**
```
Error: Invalid Azure region specified
```
- Use Azure CLI: `az account list-locations --output table`
- Common regions: `eastus`, `westus2`, `centralus`, `westeurope`

**Tag Limit Exceeded**
```
Error: Maximum of 50 tags are allowed
```
- Review current tags and remove unnecessary ones
- Consider using tag hierarchies for organization

**RBAC Principal Not Found**
```
Error: Principal ID not found in Azure AD
```
- Verify the principal ID exists: `az ad user show --id <principal-id>`
- Ensure proper permissions to assign roles

### Getting Help

- 📖 Check the [examples](./examples/) directory for implementation patterns
- 🐛 [Open an issue](https://github.com/aj-geddes/terraform-module-demo-v2/issues) for bugs or feature requests
- 💬 [Start a discussion](https://github.com/aj-geddes/terraform-module-demo-v2/discussions) for questions
- 📧 Contact the maintainer for security issues

### Performance Considerations

- **Resource Locks**: Minimal performance impact, added security benefit
- **RBAC Assignments**: Scale linearly with number of assignments
- **Diagnostic Settings**: Small overhead for comprehensive logging
- **Tag Validation**: Client-side validation with no Azure API impact

## License

This project is licensed under the Apache License 2.0 - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

- [HashiCorp Terraform](https://www.terraform.io/) for the amazing infrastructure as code platform
- [Microsoft Azure](https://azure.microsoft.com/) for the cloud infrastructure
- [terraform-docs](https://terraform-docs.io/) for automated documentation generation
- The Terraform community for best practices and inspiration

---

⭐ **Star this repository** if you find it useful!

📢 **Share feedback** through issues or discussions to help improve this module.

🤝 **Contribute** by submitting pull requests or feature suggestions.
