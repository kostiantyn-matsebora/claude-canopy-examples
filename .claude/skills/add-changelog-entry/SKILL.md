---
name: add-changelog-entry
description: Add a new version entry to CHANGELOG.md. Reads recent git commits since the last tag, groups them by type (Added / Changed / Fixed / Removed), and prepends a formatted entry following Keep a Changelog conventions.
argument-hint: "<version>  (e.g. 1.2.0)"
---

Add changelog entry for version: $ARGUMENTS

---

## Tree

```
add-changelog-entry
├── Validate $ARGUMENTS is a valid semver string
├── IF << not valid semver
│   └── END $ARGUMENTS is not a valid semver string
├── IF << CHANGELOG.md does not exist
│   └── create CHANGELOG.md from `templates/changelog.md`
├── COLLECT_COMMITS >> commits
├── Read `constants/levels.md` for valid change categories
├── CLASSIFY_COMMITS << commits >> {added, changed, fixed, removed}
├── SHOW_PLAN >> version | date | added | changed | fixed | removed
├── ASK << Proceed? | Yes | No
├── IF << Yes
│   ├── Read `policies/changelog-rules.md` for entry formatting rules
│   ├── PREPEND_ENTRY << version
│   └── VERIFY_EXPECTED << verify/verify-expected.md
└── ELSE
    └── Cancelled by user.
```

---

## Rules

- Version must follow semver — validate strictly before proceeding

## Response: version | entry_line_count | commit_count_processed
