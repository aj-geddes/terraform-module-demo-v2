# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Planned
- GitHub Actions workflow for CI/CD
- Automated testing with terraform-test
- Integration with Azure Policy assignments
- Support for diagnostic settings with Storage Account destination

## [1.0.0] - 2025-06-07

### Added
- Initial release of Azure Resource Group Terraform module
- Comprehensive input validation for name, location, and tags
- Resource lock support with configurable levels (CanNotDelete, ReadOnly)
- RBAC role assignment capabilities with built-in role validation
- Diagnostic settings integration with Log Analytics workspace
- Sensitive output handling for security-related information
- Comprehensive documentation with terraform-docs formatting
- Multiple usage examples (basic, advanced, multi-environment)
- Apache 2.0 licensing
- Production-ready configuration with security best practices

### Features
- **Core Resources**:
  - Azure Resource Group creation with lifecycle management
  - Optional management locks for resource protection
  - RBAC role assignments with validation

- **Security & Compliance**:
  - Comprehensive input validation
  - Sensitive data handling
  - Audit trail with timestamps
  - Azure Security Benchmark alignment

- **Monitoring & Observability**:
  - Diagnostic settings support
  - Activity log configuration
  - Log Analytics workspace integration

- **Governance & Tagging**:
  - Advanced tag validation (max 50 tags, length limits)
  - Reserved tag prefix protection
  - Automatic metadata tagging
  - Organizational tag standards

- **Developer Experience**:
  - terraform-docs compatible documentation
  - Comprehensive validation error messages
  - Multiple working examples
  - Clear upgrade and migration paths

### Technical Requirements
- Terraform >= 1.5.0
- Azure Provider (azurerm) >= 3.0, < 5.0
- Azure AD Provider (azuread) >= 2.0
- Valid Azure subscription with appropriate permissions

### Breaking Changes
- N/A (Initial release)

### Security
- All outputs containing sensitive information are marked as sensitive
- Input validation prevents common misconfigurations
- RBAC assignments use principle of least privilege
- Resource locks prevent accidental deletion

### Documentation
- Comprehensive README with multiple usage patterns
- terraform-docs formatted tables for all inputs/outputs
- Validation rules clearly documented with examples
- Troubleshooting guide with common issues
- Security and compliance guidance

---

## Version History Summary

- **v1.0.0**: Initial production-ready release with full feature set
- **Future**: Enhanced testing, automation, and additional Azure integrations

## Migration Guide

### From v0.x (Unreleased)
This is the initial stable release. No migration required.

### Upgrade Process
1. Review [CHANGELOG.md](CHANGELOG.md) for breaking changes
2. Update module source to new version
3. Run `terraform plan` to review changes
4. Apply changes using `terraform apply`

## Contributing

See [Contributing Guidelines](CONTRIBUTING.md) for information on how to contribute to this project.

## Support

- **Documentation**: Check the comprehensive [README.md](README.md)
- **Issues**: [GitHub Issues](https://github.com/aj-geddes/terraform-module-demo-v2/issues)
- **Discussions**: [GitHub Discussions](https://github.com/aj-geddes/terraform-module-demo-v2/discussions)
- **Security**: See [Security Policy](SECURITY.md) for vulnerability reporting

## License

This project is licensed under the Apache License 2.0 - see the [LICENSE](LICENSE) file for details.
