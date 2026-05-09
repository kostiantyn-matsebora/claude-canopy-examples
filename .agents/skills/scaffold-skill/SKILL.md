---
name: scaffold-skill
description: Generate a new Canopy skill skeleton — creates SKILL.md, references/ops.md, and standard agentskills.io subdirectories (scripts/, references/, assets/) under .claude/skills/<name>/. Uses the markdown list tree syntax.
compatibility: Requires the canopy-runtime skill (published at github.com/kostiantyn-matsebora/claude-canopy). Install with any agentskills.io-compatible tool — e.g. `gh skill install`, `git clone`, the repo's `install.sh`/`install.ps1`, or the Claude Code plugin marketplace. Supports Claude Code and GitHub Copilot.
metadata:
  argument-hint: "<skill-name>"
  canopy-features: [interaction, control-flow, verify]
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

New skill name: $ARGUMENTS

---

## Tree

* scaffold-skill
  * validate $ARGUMENTS is a valid kebab-case identifier
  * IF << $ARGUMENTS is not valid kebab-case
    * END Skill name must be kebab-case (e.g. my-skill)
  * IF << <skills-root>/$ARGUMENTS/ exists
    * END Skill already exists — choose a different name or delete the existing one first
  * SHOW_PLAN >> skill name | files to create | directories to create
  * ASK << Proceed? | Yes | No
  * IF << Yes
    * CREATE_SKILL_FILES << $ARGUMENTS
    * confirm files created
    * print next steps to user
    * VERIFY_EXPECTED << assets/verify/verify-expected.md
  * ELSE
    * Cancelled by user.

## Rules

- Never overwrite an existing skill directory
- Generated SKILL.md must use the markdown list tree syntax (`*` nested lists), include the `compatibility` field, and open with the safety preamble guard block
- Skill file must be named exactly `SKILL.md` (uppercase) per agentskills.io spec

## Response: Summary / Files created / Next steps
