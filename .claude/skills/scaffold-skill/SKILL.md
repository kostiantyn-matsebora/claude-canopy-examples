---
name: scaffold-skill
description: Generate a new Canopy skill skeleton — creates SKILL.md, references/ops.md, and standard agentskills.io subdirectories (scripts/, references/, assets/) under .claude/skills/<name>/. Uses the markdown list tree syntax.
compatibility: Requires canopy-runtime for Claude Code (`gh skill install kostiantyn-matsebora/claude-canopy canopy-runtime --agent claude-code`) or GitHub Copilot (`--agent github-copilot`). Execution on other platforms is not supported.
metadata:
  argument-hint: "<skill-name>"
---

> **Runtime required:** This skill uses Canopy tree notation and requires the
> canopy-runtime execution engine. If canopy-runtime is not active in your
> current context, **stop immediately** — do not attempt to execute this skill.
> Inform the user: "canopy-runtime must be installed and activated first.
> Run: `gh skill install kostiantyn-matsebora/claude-canopy canopy-runtime --agent claude-code`"

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
