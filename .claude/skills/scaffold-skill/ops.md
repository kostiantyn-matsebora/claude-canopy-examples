# scaffold-skill — Local Ops

---

## CREATE_SKILL_FILES << skill_name

Create the full skeleton for a new skill under `.claude/skills/<skill_name>/`.

* CREATE_SKILL_FILES << skill_name
  * create `.claude/skills/<skill_name>/` directory
  * write `skill.md` from `templates/skill.md`
  * write `ops.md` from `templates/ops.md`
  * create subdirectories: `schemas/`, `policies/`, `templates/`, `constants/`, `commands/`, `verify/`
