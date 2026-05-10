---
name: bump-version
description: Bump the project version across all version-bearing files (package.json, pyproject.toml, Cargo.toml, go.mod, etc.) and prepend a CHANGELOG entry. Uses the markdown list tree syntax.
compatibility: Requires the canopy-runtime skill (published at github.com/kostiantyn-matsebora/claude-canopy). Install with any agentskills.io-compatible tool — e.g. `gh skill install`, `git clone`, the repo's `install.sh`/`install.ps1`, or the Claude Code plugin marketplace. Supports Claude Code and GitHub Copilot.
metadata:
  argument-hint: "<new-version>  (e.g. 2.1.0)"
  canopy-features: [interaction, control-flow, verify, subagent]
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

New version: $ARGUMENTS

---

## Tree

* bump-version
  * **EXPLORE** >> context
  * IF << $ARGUMENTS is not a valid semver string
    * END Version argument is not valid semver — expected MAJOR.MINOR.PATCH
  * IF << new version is not greater than current version
    * END New version must be greater than current version (context.current_version)
  * bind new_version = $ARGUMENTS
  * SHOW_PLAN >> current version | new version | files to update | changelog action
  * ASK << Proceed? | Yes | No
  * Read `assets/policies/bump-rules.md` for version update constraints
  * BUMP_FILES << context | new_version
  * IF << CHANGELOG.md exists
    * BUMP_CHANGELOG << new_version
  * ELSE
    * skip changelog
  * VERIFY_EXPECTED << assets/verify/verify-expected.md

## Rules

- Never modify a file if the version string cannot be found unambiguously
- All version strings must be updated atomically — partial updates are an error

## Response: new version | files updated | changelog updated
