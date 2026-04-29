---
name: review-file
description: Perform a structured code review of a file or directory. Reports issues grouped by severity (critical / warning / info) with concrete suggested fixes. Use before opening a pull request or after significant changes.
compatibility: Requires canopy-runtime for Claude Code (`gh skill install kostiantyn-matsebora/claude-canopy canopy-runtime --agent claude-code`) or GitHub Copilot (`--agent github-copilot`). Execution on other platforms is not supported.
metadata:
  argument-hint: "<file-or-directory>"
---

> **Runtime required:** This skill uses Canopy tree notation and requires the
> canopy-runtime execution engine. If canopy-runtime is not active in your
> current context, **stop immediately** — do not attempt to execute this skill.
> Inform the user: "canopy-runtime must be installed and activated first.
> Run: `gh skill install kostiantyn-matsebora/claude-canopy canopy-runtime --agent claude-code`"

Review: $ARGUMENTS

---

## Agent

**explore** — read the review target and detect project coding standards. Output contract: `assets/schemas/explore-schema.json`.

Sub-tasks:
- Read all files under `$ARGUMENTS`
- Detect linting and type-check config files at the project root — see `assets/constants/review-config-files.md`

---

## Tree

```
review-file
├── EXPLORE >> context
├── SHOW_PLAN >> target | file_count | critical_count | warning_count | info_count
├── Read `assets/policies/review-rules.md` for severity classification rules
├── IF << critical findings present
│   └── REPORT_FINDINGS << critical
├── IF << warning findings present
│   └── REPORT_FINDINGS << warning
├── IF << info findings present
│   └── REPORT_FINDINGS << info
└── IF << no findings at any severity
    └── report from `assets/constants/no-findings-message.md`
```

---

## Rules

- Only report what is observable in the provided files — do not speculate
- Suggested fixes must be concrete: show the corrected code snippet, not just a description

## Response: target | critical | warnings | info | overall_verdict
