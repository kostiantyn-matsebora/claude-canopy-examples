# Expected State After bump-version

- [ ] All files listed in `context.files_to_update` contain the new version string
- [ ] No file listed contains the old version string in any version field
- [ ] If `changelog_exists` was true: CHANGELOG.md has exactly one entry at the top matching the new version (added by this run, or already present from a prior `add-changelog-entry` run for the same version)
- [ ] No other content in any updated file was changed beyond the version string
