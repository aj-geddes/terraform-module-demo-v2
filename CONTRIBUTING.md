# Contributing to Azure Resource Group Terraform Module v2

Thank you for your interest in contributing to this Terraform module! This document provides guidelines and information for contributors.

## Table of Contents

- [Code of Conduct](#code-of-conduct)
- [Getting Started](#getting-started)
- [Development Workflow](#development-workflow)
- [Coding Standards](#coding-standards)
- [Testing](#testing)
- [Documentation](#documentation)
- [Pull Request Process](#pull-request-process)
- [Release Process](#release-process)

## Code of Conduct

This project adheres to a simple code of conduct:
- Be respectful and inclusive
- Focus on constructive feedback
- Help others learn and grow
- Maintain professional communication

## Getting Started

### Prerequisites

- [Terraform](https://www.terraform.io/downloads.html) >= 1.5.0
- [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli) >= 2.40.0
- [terraform-docs](https://terraform-docs.io/) for documentation generation
- [pre-commit](https://pre-commit.com/) for code quality hooks (optional)
- Valid Azure subscription for testing

### Development Setup

1. **Fork and Clone**:
   ```bash
   git clone https://github.com/YOUR-USERNAME/terraform-module-demo-v2.git
   cd terraform-module-demo-v2
   ```

2. **Authenticate with Azure**:
   ```bash
   az login
   ```

3. **Install Development Tools** (optional):
   ```bash
   # Install pre-commit if desired
   pip install pre-commit
   pre-commit install
   ```

## Development Workflow

### Branch Strategy

- **main**: Stable, production-ready code
- **feature/***: New features or enhancements
- **fix/***: Bug fixes
- **docs/***: Documentation updates
- **refactor/***: Code refactoring without functional changes

### Making Changes

1. **Create a Feature Branch**:
   ```bash
   git checkout -b feature/your-feature-name
   ```

2. **Make Your Changes**: Follow the coding standards below

3. **Test Your Changes**: Run validation and testing steps

4. **Commit Your Changes**:
   ```bash
   git add .
   git commit -m "feat: add new validation for resource naming"
   ```

5. **Push and Create PR**:
   ```bash
   git push origin feature/your-feature-name
   ```

## Coding Standards

### Terraform Best Practices

- **Formatting**: Use `terraform fmt -recursive` for consistent formatting
- **Validation**: Ensure `terraform validate` passes
- **Naming**: Use clear, descriptive names for variables, resources, and outputs
- **Comments**: Add comments for complex logic or business rules
- **Versioning**: Pin provider versions appropriately

### Variable Guidelines

- **Required Variables**: Clearly document required vs optional variables
- **Validation**: Add validation blocks for input constraints
- **Descriptions**: Provide clear, helpful descriptions with examples
- **Types**: Use specific types (string, number, bool, list, map)
- **Defaults**: Provide sensible defaults for optional variables

### Resource Guidelines

- **Naming**: Use consistent naming patterns across resources
- **Tags**: Support tagging consistently across all resources
- **Lifecycle**: Use lifecycle rules appropriately (prevent_destroy, etc.)
- **Dependencies**: Use explicit depends_on when implicit dependencies aren't sufficient

### Output Guidelines

- **Descriptions**: Provide clear descriptions explaining the output's purpose
- **Sensitivity**: Mark sensitive outputs appropriately
- **Usefulness**: Only output information that consumers will actually use
- **Naming**: Use consistent naming patterns

## Testing

### Validation Testing

```bash
# Format check
terraform fmt -check -recursive

# Validate syntax
terraform validate

# Example testing
cd examples/basic
terraform init
terraform plan
cd ../advanced
terraform init
terraform plan
```

### Integration Testing

1. **Basic Example**:
   ```bash
   cd examples/basic
   terraform init
   terraform apply -auto-approve
   terraform destroy -auto-approve
   ```

2. **Advanced Example** (requires customization):
   ```bash
   cd examples/advanced
   # Update variables for your environment
   terraform init
   terraform plan
   # Manual apply/destroy as needed
   ```

### Adding Tests

When adding new features:
- Add validation tests for new variables
- Create or update examples demonstrating the feature
- Ensure all examples can `terraform plan` successfully
- Test edge cases and error conditions

## Documentation

### README Updates

- Keep the main README.md up to date with new features
- Update usage examples when changing the interface
- Maintain the terraform-docs formatted tables

### Generating Documentation

```bash
# Generate terraform-docs (if installed)
terraform-docs markdown table --output-file README.md .
```

### CHANGELOG Updates

- Follow [Keep a Changelog](https://keepachangelog.com/) format
- Add entries for all user-facing changes
- Categorize changes as Added, Changed, Deprecated, Removed, Fixed, Security
- Update version numbers following semantic versioning

## Pull Request Process

### Before Submitting

- [ ] Code follows the project's coding standards
- [ ] All tests pass (validation, formatting, planning)
- [ ] Documentation is updated for any changes
- [ ] CHANGELOG.md is updated with your changes
- [ ] Examples demonstrate new functionality (if applicable)
- [ ] Commit messages follow conventional commits format

### PR Description Template

```markdown
## Description
Brief description of the changes

## Type of Change
- [ ] Bug fix (non-breaking change that fixes an issue)
- [ ] New feature (non-breaking change that adds functionality)
- [ ] Breaking change (fix or feature that would cause existing functionality to not work as expected)
- [ ] Documentation update

## Testing
- [ ] terraform fmt passes
- [ ] terraform validate passes
- [ ] Examples can be planned successfully
- [ ] Manual testing completed (describe what was tested)

## Documentation
- [ ] README.md updated (if needed)
- [ ] CHANGELOG.md updated
- [ ] New variables/outputs documented
- [ ] Examples updated (if needed)

## Additional Notes
Any additional information about the changes
```

### Review Process

1. **Automated Checks**: Ensure all CI checks pass
2. **Code Review**: Maintainer will review code quality and design
3. **Testing**: Manual testing may be performed
4. **Documentation**: Documentation completeness will be verified
5. **Approval**: Changes will be approved and merged

## Release Process

### Semantic Versioning

This project follows [Semantic Versioning](https://semver.org/):

- **MAJOR**: Breaking changes to the public interface
- **MINOR**: New functionality that is backwards compatible
- **PATCH**: Backwards compatible bug fixes

### Release Checklist

- [ ] All changes documented in CHANGELOG.md
- [ ] Version numbers updated consistently
- [ ] Examples tested and working
- [ ] Documentation is current and accurate
- [ ] Git tag created with version number
- [ ] GitHub release created with release notes

## Issue Reporting

### Bug Reports

Please include:
- Clear description of the issue
- Steps to reproduce
- Expected vs actual behavior
- Terraform version and Azure provider version
- Relevant configuration snippets
- Error messages (full text)

### Feature Requests

Please include:
- Clear description of the desired functionality
- Use case and business justification
- Proposed implementation approach (if any)
- Consideration of backwards compatibility

## Questions and Support

- **Documentation**: Check the [README.md](README.md) first
- **Issues**: [GitHub Issues](https://github.com/aj-geddes/terraform-module-demo-v2/issues) for bugs and feature requests
- **Discussions**: [GitHub Discussions](https://github.com/aj-geddes/terraform-module-demo-v2/discussions) for questions and general discussion

## Recognition

Contributors will be recognized in:
- GitHub contributors list
- Release notes for significant contributions
- Special recognition for major enhancements

Thank you for contributing to make this module better for everyone! 🎉
