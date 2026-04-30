# Expected State After bump-version

- [ ] All files listed in `context.files_to_update` contain the new version string
- [ ] No file listed contains the old version string in any version field
- [ ] If `changelog_exists` was true: CHANGELOG.md has a new entry at the top matching the new version and today's date
- [ ] No other content in any updated file was changed beyond the version string
