---
name: generate-readme
description: Analyze the project structure and generate or update README.md. Covers purpose, prerequisites, installation, usage, and contributing sections. Preserves any custom sections the user has already written.
compatibility: Requires the canopy-runtime skill (published at github.com/kostiantyn-matsebora/claude-canopy). Install with any agentskills.io-compatible tool — e.g. `gh skill install`, `git clone`, the repo's `install.sh`/`install.ps1`, or the Claude Code plugin marketplace. Supports Claude Code and GitHub Copilot.
metadata:
  argument-hint: "[target-path]  (default: ./README.md)"
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

Generate or update README at: $ARGUMENTS (default: README.md)

---

## Tree

```
generate-readme
├── **EXPLORE** >> context
├── SHOW_PLAN >> target_file | sections | detected_language | detected_deps
├── ASK << Proceed with generation? | Yes | No
├── IF << user chose No
│   └── END Cancelled.
├── Read `assets/policies/readme-rules.md` for content and preservation rules.
├── IF << README already exists at target_file
│   └── MERGE_README << context
├── ELSE
│   └── CREATE_README << context
└── VERIFY_EXPECTED << assets/verify/verify-expected.md
```

---

## Rules

- Never overwrite custom sections the user has written — preserve them
- Keep code examples minimal but runnable

## Response: target_file | sections_written | sections_preserved
