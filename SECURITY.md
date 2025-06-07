# Security Policy

## Supported Versions

We actively support the following versions of this Terraform module:

| Version | Supported          |
| ------- | ------------------ |
| 1.0.x   | :white_check_mark: |
| < 1.0   | :x:                |

## Security Features

This Terraform module implements several security best practices:

### Built-in Security Features

- **Resource Locks**: Prevent accidental deletion or modification of critical resources
- **RBAC Integration**: Fine-grained access control with role-based permissions
- **Input Validation**: Comprehensive validation to prevent misconfigurations
- **Sensitive Output Handling**: Proper marking and handling of sensitive data
- **Audit Trail**: Timestamp tracking and workspace identification for compliance

### Security Configurations

- **Management Locks**: Optional resource locks with configurable levels (CanNotDelete, ReadOnly)
- **Role Assignments**: Built-in RBAC with validated Azure role definitions
- **Diagnostic Settings**: Integration with Azure Monitor for audit logging
- **Tag Validation**: Prevention of reserved tag prefixes and enforcement of limits
- **Provider Constraints**: Pinned provider versions for consistent behavior

## Security Best Practices

### When Using This Module

1. **Authentication**: Use managed identities or service principals with least privilege
2. **State Management**: Store Terraform state in encrypted, access-controlled backends
3. **Secrets**: Never store sensitive data in Terraform configuration files
4. **Access Control**: Implement proper RBAC for both Azure resources and Terraform operations
5. **Monitoring**: Enable diagnostic settings for audit logging and compliance

### Production Deployment Recommendations

- Enable resource locks for critical environments
- Configure diagnostic settings with Log Analytics workspace
- Implement comprehensive tagging for governance
- Use prevent_destroy lifecycle rules for critical resources
- Regular review of RBAC assignments and permissions

## Vulnerability Reporting

### Reporting Security Issues

**Please do not report security vulnerabilities through public GitHub issues.**

Instead, please report them responsibly:

1. **Email**: Send security reports to the repository maintainer
2. **Include**: Detailed description of the vulnerability
3. **Provide**: Steps to reproduce (if applicable)
4. **Attach**: Any relevant configuration examples or logs
5. **Specify**: Affected versions and potential impact

### What to Include

A good security report includes:

- **Description**: Clear explanation of the vulnerability
- **Impact**: Potential security implications
- **Reproduction**: Steps to reproduce the issue
- **Environment**: Terraform version, provider versions, Azure environment
- **Configuration**: Relevant (sanitized) Terraform configuration
- **Suggested Fix**: If you have ideas for remediation

### Response Timeline

- **Acknowledgment**: Within 48 hours of report
- **Initial Assessment**: Within 1 week
- **Status Updates**: Weekly until resolution
- **Fix Delivery**: Varies based on complexity and severity
- **Public Disclosure**: After fix is available and deployed

## Security Considerations

### Terraform State Security

- **Remote State**: Always use encrypted remote state backends
- **Access Control**: Limit access to state files
- **Sensitive Data**: Be aware that state files may contain sensitive information
- **Backup**: Ensure state backups are also secured

### Azure Security

- **Service Principal**: Use dedicated service principals with minimal permissions
- **Network Security**: Consider network access restrictions for resources
- **Encryption**: Enable encryption at rest and in transit where applicable
- **Monitoring**: Implement comprehensive logging and monitoring

### Configuration Security

```hcl
# Example secure configuration
module "secure_rg" {
  source = "github.com/aj-geddes/terraform-module-demo-v2"

  name     = "rg-production-app"
  location = "eastus2"
  
  # Enable security features
  prevent_destroy      = true
  enable_resource_lock = true
  lock_level          = "CanNotDelete"
  
  # Enable monitoring
  enable_diagnostic_settings = true
  log_analytics_workspace_id = var.log_analytics_workspace_id
  diagnostic_retention_days  = 90
  
  # Implement RBAC
  role_assignments = {
    security_team = {
      role_definition_name = "Reader"
      principal_id         = var.security_team_principal_id
      description          = "Security team compliance access"
    }
  }
  
  tags = {
    Environment        = "production"
    DataClassification = "confidential"
    Owner             = "security-team@company.com"
  }
}
```

### Common Security Anti-patterns to Avoid

- **Hardcoded Secrets**: Never include passwords, keys, or tokens in configuration
- **Overprivileged Access**: Avoid using Owner roles when Contributor is sufficient
- **Unprotected Resources**: Don't disable resource locks in production
- **Missing Monitoring**: Always enable diagnostic settings for audit trails
- **Weak Tagging**: Implement consistent tagging for security and compliance

## Security Updates

### Staying Informed

- **Watch**: This repository for security-related releases
- **Subscribe**: To release notifications
- **Monitor**: Azure security advisories for provider-related issues
- **Review**: CHANGELOG.md for security-related updates

### Update Process

1. **Review**: Security-related changelog entries
2. **Test**: Updates in non-production environments first
3. **Plan**: Deployment during maintenance windows
4. **Monitor**: Resources after updates for any issues
5. **Verify**: Security configurations remain intact

## Security Resources

### Azure Security

- [Azure Security Center](https://docs.microsoft.com/en-us/azure/security-center/)
- [Azure Security Benchmark](https://docs.microsoft.com/en-us/azure/security/benchmarks/)
- [Azure RBAC Documentation](https://docs.microsoft.com/en-us/azure/role-based-access-control/)

### Terraform Security

- [Terraform Security Guide](https://www.terraform.io/docs/cloud/guides/recommended-practices/part1)
- [Terraform State Security](https://www.terraform.io/docs/language/state/sensitive-data.html)

### General Security

- [OWASP Top 10](https://owasp.org/www-project-top-ten/)
- [CIS Controls](https://www.cisecurity.org/controls/)

## Compliance

This module supports compliance with:

- **SOC2**: Through audit logging and access controls
- **ISO 27001**: Via resource governance and monitoring
- **Azure Security Benchmark**: Following Microsoft security recommendations
- **NIST**: Identity and access management best practices

## Contact

For security-related questions or concerns:

- **Security Issues**: Use responsible disclosure process above
- **General Questions**: Create a GitHub discussion
- **Documentation**: Refer to README.md and examples

---

**Remember**: Security is a shared responsibility. This module provides security features and best practices, but proper implementation and ongoing security management remain your responsibility.
