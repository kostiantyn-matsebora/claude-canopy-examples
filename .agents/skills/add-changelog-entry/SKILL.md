---
name: add-changelog-entry
description: Add a new version entry to CHANGELOG.md. Reads recent git commits since the last tag, groups them by type (Added / Changed / Fixed / Removed), and prepends a formatted entry following Keep a Changelog conventions.
compatibility: Requires the canopy-runtime skill (published at github.com/kostiantyn-matsebora/claude-canopy). Install with any agentskills.io-compatible tool — e.g. `gh skill install`, `git clone`, the repo's `install.sh`/`install.ps1`, or the Claude Code plugin marketplace. Supports Claude Code and GitHub Copilot.
metadata:
  argument-hint: "<version>  (e.g. 1.2.0)"
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

Add changelog entry for version: $ARGUMENTS

---

## Tree

```
add-changelog-entry
├── Validate $ARGUMENTS is a valid semver string
├── IF << not valid semver
│   └── END $ARGUMENTS is not a valid semver string
├── IF << CHANGELOG.md does not exist
│   └── create CHANGELOG.md from `assets/templates/changelog.md`
├── COLLECT_COMMITS >> commits
├── Read `assets/constants/levels.md` for valid change categories
├── CLASSIFY_COMMITS << commits >> {added, changed, fixed, removed}
├── SHOW_PLAN >> version | date | added | changed | fixed | removed
├── ASK << Proceed? | Yes | No
├── IF << Yes
│   ├── Read `assets/policies/changelog-rules.md` for entry formatting rules
│   ├── PREPEND_ENTRY << version
│   └── VERIFY_EXPECTED << assets/verify/verify-expected.md
└── ELSE
    └── Cancelled by user.
```

---

## Rules

- Version must follow semver — validate strictly before proceeding

## Response: version | entry_line_count | commit_count_processed
