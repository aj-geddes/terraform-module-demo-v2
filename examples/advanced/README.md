# Advanced Example - Azure Resource Group Module

This example demonstrates the full capabilities of the Azure Resource Group module with security features, RBAC assignments, and monitoring configuration.

## Configuration

This advanced example includes:
- Resource locks for protection
- RBAC role assignments
- Diagnostic settings with Log Analytics
- Comprehensive tagging strategy
- Production-ready security configuration

## Prerequisites

Before running this example, ensure you have:
- Valid Azure subscription with appropriate permissions
- Log Analytics workspace (or modify the example to create one)
- Azure AD principal IDs for role assignments
- Proper Azure CLI authentication

## Usage

1. **Update Variables**: Modify `terraform.tfvars.example` with your values
2. **Initialize Terraform**: `terraform init`
3. **Plan Deployment**: `terraform plan`
4. **Apply Configuration**: `terraform apply`
5. **Verify Resources**: Check Azure portal for created resources
6. **Clean Up**: `terraform destroy` when done

## Features Demonstrated

- ✅ Resource lock protection (CanNotDelete)
- ✅ RBAC assignments with multiple roles
- ✅ Diagnostic settings integration
- ✅ Comprehensive tagging with organizational standards
- ✅ Lifecycle management with prevent_destroy
- ✅ Security best practices
- ✅ Monitoring and compliance readiness

## Security Considerations

This example implements:
- Resource locks to prevent accidental deletion
- Role-based access control with least privilege
- Audit logging through diagnostic settings
- Comprehensive tagging for governance
- Sensitive output protection

## Customization

Modify the configuration to match your organization's:
- Naming conventions
- RBAC requirements
- Tagging standards
- Monitoring and logging strategy
- Compliance requirements

## Production Readiness

This example follows production best practices:
- Infrastructure protection through locks
- Comprehensive access control
- Audit and compliance logging
- Proper resource governance
- Security-first configuration
