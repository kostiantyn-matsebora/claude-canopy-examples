---
name: review-file
description: Perform a structured code review of a file or directory. Reports issues grouped by severity (critical / warning / info) with concrete suggested fixes. Use before opening a pull request or after significant changes.
argument-hint: "<file-or-directory>"
---

Review: $ARGUMENTS

---

## Agent

**explore** — read the review target and detect project coding standards. Output contract: `schemas/explore-schema.json`.

Sub-tasks:
- Read all files under `$ARGUMENTS`
- Detect linting and type-check config files at the project root — see `constants/review-config-files.md`

---

## Tree

```
review-file
├── EXPLORE >> context
├── SHOW_PLAN >> target | file_count | critical_count | warning_count | info_count
├── Read `policies/review-rules.md` for severity classification rules
├── IF << critical findings present
│   └── REPORT_FINDINGS << critical
├── IF << warning findings present
│   └── REPORT_FINDINGS << warning
├── IF << info findings present
│   └── REPORT_FINDINGS << info
└── IF << no findings at any severity
    └── report from `constants/no-findings-message.md`
```

---

## Rules

- Only report what is observable in the provided files — do not speculate
- Suggested fixes must be concrete: show the corrected code snippet, not just a description

## Response: target | critical | warnings | info | overall_verdict
