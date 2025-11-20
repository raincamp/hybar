# GitHub Repository Setup Commands

This document contains GitHub CLI commands and manual instructions to complete the repository configuration for Issues #14 and #15.

---

## Issue #14: Configure Repository Settings

### About Section (Manual - GitHub Web UI)

These settings must be configured through the GitHub web interface:

1. Go to: https://github.com/raincamp/hybar
2. Click the ⚙️ gear icon next to "About"
3. Configure:
   - **Description**: `A dedicated 2-button action bar for 'hell yeah brother' guild chat and yell communication in WoW Classic Era`
   - **Website**: `https://www.curseforge.com/wow/addons/hybar`
   - **Topics**: `world-of-warcraft`, `wow-addon`, `wow-classic`, `classic-era`, `action-bar`, `lua`, `addon`, `guild-chat`, `warcraft-addon`, `curseforge`
   - **✅ Releases** (check this box)
   - **Social preview image**: (Optional - defer to Phase 3)

### Features Configuration (GitHub CLI)

```bash
# Enable Issues (should already be enabled)
gh repo edit raincamp/hybar --enable-issues

# Enable Discussions
gh repo edit raincamp/hybar --enable-discussions

# Disable Wiki
gh repo edit raincamp/hybar --enable-wiki=false
```

### Pull Request Settings (Manual - GitHub Web UI)

These settings must be configured through Settings → General → Pull Requests:

1. Go to: https://github.com/raincamp/hybar/settings
2. Scroll to "Pull Requests" section
3. Configure:
   - ✅ **Allow squash merging** (set as default)
   - ✅ **Allow merge commits**
   - ✅ **Allow rebase merging**
   - **Default commit message**: Select "Pull request title"
   - ✅ **Automatically delete head branches**

### GitHub Discussions Setup (Manual - if enabled)

After enabling Discussions via CLI:

1. Go to: https://github.com/raincamp/hybar/discussions
2. Click "Categories" tab
3. Create/configure categories:
   - **General** - General discussion about hybar
   - **Q&A** - Questions and answers (✅ enable answer marking)
   - **Ideas** - Feature ideas before becoming formal issues
   - **Show and Tell** - User showcases, macros, creative uses
4. Create a pinned welcome discussion

---

## Issue #15: Set Up Label System and Branch Protection

### Label System (GitHub CLI)

Run these commands to create the comprehensive label system:

```bash
# Type Labels
gh label create "type: bug" --description "Something isn't working" --color "d73a4a" --repo raincamp/hybar
gh label create "type: enhancement" --description "New feature or request" --color "a2eeef" --repo raincamp/hybar
gh label create "type: documentation" --description "Documentation improvements" --color "0075ca" --repo raincamp/hybar
gh label create "type: refactor" --description "Code refactoring" --color "fbca04" --repo raincamp/hybar
gh label create "type: performance" --description "Performance improvements" --color "f9d0c4" --repo raincamp/hybar

# Priority Labels
gh label create "priority: critical" --description "Requires immediate attention" --color "b60205" --repo raincamp/hybar
gh label create "priority: high" --description "High priority" --color "d93f0b" --repo raincamp/hybar
gh label create "priority: medium" --description "Medium priority" --color "fbca04" --repo raincamp/hybar
gh label create "priority: low" --description "Low priority" --color "0e8a16" --repo raincamp/hybar

# Status Labels
gh label create "status: needs-triage" --description "Needs review" --color "e4e669" --repo raincamp/hybar
gh label create "status: in-progress" --description "Being worked on" --color "c2e0c6" --repo raincamp/hybar
gh label create "status: blocked" --description "Blocked by dependency" --color "d93f0b" --repo raincamp/hybar
gh label create "status: wontfix" --description "Will not be worked on" --color "ffffff" --repo raincamp/hybar
gh label create "status: duplicate" --description "Duplicate issue" --color "cfd3d7" --repo raincamp/hybar

# Special Labels
gh label create "good first issue" --description "Good for newcomers" --color "7057ff" --repo raincamp/hybar
gh label create "help wanted" --description "Extra attention needed" --color "008672" --repo raincamp/hybar
gh label create "question" --description "Further information requested" --color "d876e3" --repo raincamp/hybar
gh label create "wow-api-limitation" --description "Limited by WoW API" --color "fef2c0" --repo raincamp/hybar

# WoW-Specific Labels
gh label create "classic-era" --description "Classic Era specific" --color "1d76db" --repo raincamp/hybar
gh label create "localization" --description "Translation related" --color "c5def5" --repo raincamp/hybar
```

**Note**: Some of these labels may conflict with GitHub's default labels (e.g., "bug", "enhancement", "documentation"). You may need to delete or rename the default labels first:

```bash
# Optional: Delete default labels if they conflict
gh label delete "bug" --repo raincamp/hybar --yes
gh label delete "enhancement" --repo raincamp/hybar --yes
gh label delete "documentation" --repo raincamp/hybar --yes
```

### Branch Protection (Manual - GitHub Web UI)

Branch protection rules must be configured through the GitHub web interface:

1. Go to: https://github.com/raincamp/hybar/settings/branches
2. Click "Add rule" or "Add branch protection rule"
3. Configure for `main` branch:
   - **Branch name pattern**: `main`
   - ✅ **Require a pull request before merging**
     - **Required approvals**: 1
   - ✅ **Require conversation resolution before merging**
   - ✅ **Do not allow bypassing the above settings** (include administrators)
   - ❌ **Require status checks to pass** (leave unchecked - no CI/CD initially)
   - ❌ **Require signed commits** (optional)
   - ❌ **Restrict who can push** (optional - allow maintainers)
4. Click "Create" or "Save changes"

---

## Execution Instructions

### For Issue #14:

1. Run the GitHub CLI commands for Features configuration
2. Manually configure the About section via GitHub web UI
3. Manually configure Pull Request settings via GitHub web UI
4. (Optional) Set up GitHub Discussions categories

### For Issue #15:

1. (Optional) Delete conflicting default labels
2. Run all label creation commands
3. Manually configure branch protection via GitHub web UI

---

## Verification

After completing the setup:

### Issue #14 Checklist:
- [ ] About section has description, website, and topics
- [ ] Releases are enabled
- [ ] Issues are enabled
- [ ] Discussions are enabled
- [ ] Wiki is disabled
- [ ] Pull request settings are configured
- [ ] Head branches auto-delete

### Issue #15 Checklist:
- [ ] All type labels created
- [ ] All priority labels created
- [ ] All status labels created
- [ ] All special labels created
- [ ] All WoW-specific labels created
- [ ] Branch protection enabled for `main`
- [ ] PR approval required (1 reviewer)
- [ ] Conversation resolution required

---

## Troubleshooting

**Permission Denied Errors:**
- Ensure you have admin access to the repository
- Authenticate with `gh auth login` if needed

**Label Already Exists:**
- Use `--force` flag to update existing labels
- Or delete the existing label first with `gh label delete`

**Branch Protection Not Saving:**
- Ensure you have admin privileges
- Check that all required fields are filled out

---

## Notes

- These commands use the GitHub CLI (`gh`) which must be installed and authenticated
- Some settings can only be configured through the web UI (About section, branch protection)
- Label colors use hex codes without the `#` prefix
- Pull request settings affect how contributors interact with the repository
- Branch protection ensures code quality through required reviews

---

**Last Updated**: 2025-11-20  
**Related Issues**: #14, #15  
**Part of**: Phase 2 - GitHub Standardization Plan
