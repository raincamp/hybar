## Description
<!-- Provide a clear and concise description of your changes -->

## Type of Change
<!-- Mark the relevant option with an 'x' -->

- [ ] Bug fix (non-breaking change that fixes an issue)
- [ ] New feature (non-breaking change that adds functionality)
- [ ] Breaking change (fix or feature that would cause existing functionality to not work as expected)
- [ ] Documentation update
- [ ] Code refactoring
- [ ] Performance improvement

## Sprint Context
<!-- Required: Link to the sprint milestone this PR belongs to -->

**Sprint Milestone**: <!-- e.g., Sprint 4: Commands & Feedback -->

## Related Issues
<!-- Link related issues using keywords: Closes #123, Fixes #456, Related to #789 -->

Closes #

## Dependency Check
<!-- If this PR depends on another PR being merged first, list it here -->

- [ ] No dependencies on other PRs
- [ ] Depends on PR: #

## Testing

### In-Game Testing
<!-- Describe the testing you performed -->

- [ ] Tested with `/reload` after changes
- [ ] Tested slash commands (`/hybar`, `/hellyeahbar`, `/hyb`)
- [ ] Tested configuration panel
- [ ] Tested with fresh character (no saved variables)
- [ ] Tested with existing settings

**WoW Version Tested:**
<!-- e.g., TBC Classic Anniversary 2.5.5 -->

**Test Steps Performed:**
<!-- Describe specific scenarios you tested -->
1.
2.
3.

### Screenshots / GIFs
<!-- If applicable, add screenshots or GIFs demonstrating the changes -->

## Contributor Checklist

### Code Quality
- [ ] Code follows the namespace pattern (`_hyb.module`)
- [ ] Added/updated localization strings in `locales/hybar-enUS.lua` (if applicable)
- [ ] Updated file loading order in `hybar.toc` (if adding new files)
- [ ] No Lua errors introduced (tested with `/console scriptErrors 1`)

### Documentation
- [ ] Updated `CHANGELOG.md` with changes
- [ ] Updated `CLAUDE.md` if architecture/patterns changed (if applicable)
- [ ] Updated comments for complex logic (if applicable)

### Testing
- [ ] Changes have been tested in-game
- [ ] No conflicts with other addons (tested with common addons if possible)

## Merge Readiness
<!-- For maintainers - check before merging -->

- [ ] Branch is up-to-date with main (rebase if needed)
- [ ] All conversations resolved
- [ ] CI checks passing
- [ ] Manual testing verified

## Additional Notes
<!-- Add any additional context, concerns, or notes for reviewers -->
