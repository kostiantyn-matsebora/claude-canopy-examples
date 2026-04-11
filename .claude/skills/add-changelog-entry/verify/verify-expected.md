# Expected State — add-changelog-entry

## File

- [ ] `CHANGELOG.md` exists on disk

## New entry

- [ ] `## [<version>] - <date>` heading is present as the first or second version heading
- [ ] At least one category section (`### Added`, `### Changed`, etc.) is present under the new heading
- [ ] No `<token>` placeholders remain in the file
- [ ] Existing entries below the new heading are unchanged

## Semver

- [ ] New version heading is lexicographically greater than the next heading below it
