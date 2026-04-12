# scaffold-skill — Local Ops

---

## CREATE_SKILL_FILES << skill_name >> files_created

Create the full skeleton for a new skill under `.claude/skills/<skill_name>/`.

* CREATE_SKILL_FILES << skill_name >> files_created
  * create `.claude/skills/<skill_name>/` directory
  * Read `templates/skill.md` for skill skeleton — write to `.claude/skills/<skill_name>/skill.md`
  * Read `templates/ops.md` for ops skeleton — write to `.claude/skills/<skill_name>/ops.md`
  * create subdirectories: `schemas/`, `policies/`, `templates/`, `constants/`, `commands/`, `verify/`
  * capture list of all written file paths into `files_created`
