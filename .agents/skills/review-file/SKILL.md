---
name: review-file
description: Perform a structured code review of a file or directory. Reports issues grouped by severity (critical / warning / info) with concrete suggested fixes. Use before opening a pull request or after significant changes.
compatibility: Requires the canopy-runtime skill (published at github.com/kostiantyn-matsebora/claude-canopy). Install with any agentskills.io-compatible tool — e.g. `gh skill install`, `git clone`, the repo's `install.sh`/`install.ps1`, or the Claude Code plugin marketplace. Supports Claude Code and GitHub Copilot.
metadata:
  argument-hint: "<file-or-directory>"
---

> **Runtime required.** This skill uses Canopy tree notation; canopy-runtime must be active.
>
> **Detect canopy-runtime** — present if either:
> - `canopy-runtime/SKILL.md` exists under `.claude/skills/`, `.github/skills/`, or `.agents/skills/`, OR
> - a canopy-runtime marker block exists in `CLAUDE.md` or `.github/copilot-instructions.md`.
>
> **If neither is present** — install canopy-runtime first (see the `compatibility` field for the source and install options), then re-invoke this skill.
>
> Do not interpret the `## Tree` without canopy-runtime active.

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
