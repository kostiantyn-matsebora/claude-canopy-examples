---
name: scaffold-skill
description: Generate a new Canopy skill skeleton — creates skill.md, ops.md, and supporting directories under .claude/skills/<name>/. Uses the markdown list tree syntax.
argument-hint: "<skill-name>"
---

New skill name: $ARGUMENTS

---

## Tree

* scaffold-skill
  * validate $ARGUMENTS is a valid kebab-case identifier; END if not
  * IF << .claude/skills/$ARGUMENTS already exists
    * END Skill already exists — choose a different name or delete the existing one first
  * SHOW_PLAN >> skill name | files to create | directories to create
  * ASK << Proceed? | Yes | No
  * CREATE_SKILL_FILES << $ARGUMENTS
  * confirm files created and print next steps

## Rules

- Never overwrite an existing skill directory
- Generated skill.md must use the markdown list tree syntax (`*` nested lists)

## Response: Summary / Files created / Next steps
