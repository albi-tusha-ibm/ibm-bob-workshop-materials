# Security Policy

## Reporting Security Issues

**Please do not report security vulnerabilities through public GitHub issues.**

If you discover a security vulnerability in this workshop repository, please report it to IBM's security team:

- **Email**: psirt@us.ibm.com
- **Subject**: [IBM Bob Workshop] Security Vulnerability Report

Please include the following information in your report:

- Description of the vulnerability
- Steps to reproduce the issue
- Potential impact
- Suggested fix (if available)

## Scope

This repository contains educational workshop materials. While we take security seriously, please note:

### In Scope
- Security issues in workshop documentation
- Vulnerabilities in sample code that could mislead participants
- Exposure of sensitive information in the repository
- Issues with workshop infrastructure setup scripts

### Out of Scope
- Intentional vulnerabilities in sample code (used for educational purposes)
- Security issues in third-party dependencies (unless critical)
- Theoretical attacks that require unrealistic scenarios

## Workshop Security Notes

### Sample Code Disclaimer

This workshop includes intentionally vulnerable or problematic code samples for educational purposes. These samples are clearly marked and are designed to:

- Demonstrate common security pitfalls
- Teach secure coding practices
- Show how Bob can help identify security issues

**Important**: Sample code in this workshop should NOT be used in production environments without proper security review and hardening.

### Educational Vulnerabilities

The following types of intentional issues may be present in workshop materials:

- **Module 1 (Application Engineering)**:
  - Memory leaks for troubleshooting exercises
  - Performance issues for optimization practice
  - Configuration problems for debugging scenarios

- **Module 2 (IT Infrastructure)**:
  - Misconfigured security settings for identification exercises
  - Capacity planning issues for analysis practice
  - Network configuration problems for troubleshooting

These are clearly documented in the respective module documentation.

## Security Best Practices for Workshop Facilitators

When running this workshop:

1. **Isolated Environment**: Use isolated development environments
2. **No Production Data**: Never use real production data or credentials
3. **Clean Up**: Remove workshop materials from shared systems after completion
4. **Access Control**: Limit access to workshop materials to authorized participants
5. **Credential Management**: Use dummy credentials only; never real ones

## Supported Versions

| Version | Supported          |
| ------- | ------------------ |
| Latest  | :white_check_mark: |
| Older   | :x:                |

We only support the latest version of the workshop materials. Please ensure you're using the most recent version from the main branch.

## Security Updates

Security updates to workshop materials will be:

- Applied to the main branch immediately
- Documented in release notes
- Communicated to known workshop facilitators
- Reflected in the CHANGELOG (if applicable)

## Additional Resources

- [IBM Security](https://www.ibm.com/security)
- [IBM Product Security Incident Response](https://www.ibm.com/trust/security-psirt)
- [Secure Coding Guidelines](https://www.ibm.com/security/secure-engineering)

## Questions?

For security-related questions about this workshop:

- **General Security Questions**: Open an issue with the `security` label
- **Vulnerability Reports**: Email psirt@us.ibm.com
- **Workshop Security Guidance**: Contact the workshop maintainers

---

**Last Updated**: March 2024

Thank you for helping keep the IBM Bob Workshop secure!