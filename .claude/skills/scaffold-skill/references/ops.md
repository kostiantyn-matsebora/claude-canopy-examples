# scaffold-skill — Local Ops

---

## CREATE_SKILL_FILES << skill_name >> files_created

Create the full skeleton for a new skill under `<skills-root>/<skill_name>/` using the standard agentskills.io layout.

* CREATE_SKILL_FILES << skill_name >> files_created
  * create `<skills-root>/<skill_name>/` directory
  * Read `assets/templates/skill.md`
  * substitute `<skill-name>` with `skill_name`
  * write result to `<skills-root>/<skill_name>/SKILL.md` (uppercase, exact spelling)
  * Read `assets/templates/ops.md`
  * substitute `<skill-name>` with `skill_name`
  * write result to `<skills-root>/<skill_name>/references/ops.md`
  * create subdirectories from `assets/constants/skill-subdirs.md` (standard layout: `scripts/`, `references/`, `assets/templates/`, `assets/constants/`, `assets/schemas/`, `assets/checklists/`, `assets/policies/`, `assets/verify/`)
  * capture list of all written file paths into `files_created`
