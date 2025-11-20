# Security Policy

## Supported Versions

We actively support the following versions of hybar with security updates:

| Version | Supported          |
| ------- | ------------------ |
| 1.0.x   | :white_check_mark: |
| < 1.0   | :x:                |

## WoW Addon Security Context

As a World of Warcraft addon, hybar operates within WoW's sandboxed Lua environment, which provides inherent security limitations:

- **Limited Attack Surface**: WoW addons cannot access the filesystem, execute system commands, or make arbitrary network requests
- **API Restrictions**: Only WoW-approved APIs are available
- **Client-Side Only**: All code runs locally in the game client

However, we still take security seriously for:
- Lua code injection vulnerabilities
- Malicious behavior through WoW API misuse
- Privacy concerns with saved variables
- Social engineering through addon distribution channels

## Reporting a Vulnerability

If you discover a security vulnerability in hybar, please help us maintain the security of our users by reporting it responsibly.

### Private Reporting

**Please do NOT create a public GitHub issue for security vulnerabilities.**

Instead, report vulnerabilities privately through one of these methods:

1. **GitHub Security Advisories** (Preferred)
   - Go to the [Security tab](https://github.com/hyb-devs/hybar/security/advisories)
   - Click "Report a vulnerability"
   - Provide detailed information about the vulnerability

2. **Email**
   - Send to: hyb.devs@gmail.com
   - Subject line: `[SECURITY] hybar vulnerability report`
   - Include detailed reproduction steps and impact assessment

### What to Include

Please include the following information in your report:

- **Description**: Clear description of the vulnerability
- **Impact**: What could an attacker accomplish?
- **Reproduction Steps**: Detailed steps to reproduce the issue
- **WoW Version**: Which version(s) of WoW are affected
- **Addon Version**: Which version(s) of hybar are affected
- **Proof of Concept**: Code snippets or screenshots if applicable
- **Suggested Fix**: If you have ideas for remediation (optional)

### Response Timeline

- **Initial Response**: Within 48-72 hours of receipt
- **Vulnerability Assessment**: Within 1 week
- **Fix Timeline**: Varies based on severity and complexity
  - Critical: As soon as possible
  - High: Within 2 weeks
  - Medium/Low: Next release cycle

### Coordinated Disclosure

We follow coordinated disclosure principles:

1. You report the vulnerability privately
2. We confirm receipt and assess the issue
3. We develop and test a fix
4. We release the fix in a new version
5. We publicly credit you in the release notes (unless you prefer to remain anonymous)
6. After the fix is released and users have had time to update (typically 30 days), we may publish a security advisory

### Recognition

We appreciate security researchers who help keep hybar safe. We're happy to:
- Credit you in release notes and the security advisory
- Thank you in our README (if desired)
- Recognize your contribution in our community channels

Thank you for helping keep hybar and its users safe!
