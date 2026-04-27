# scaffold-skill — Local Ops

---

## CREATE_SKILL_FILES << skill_name >> files_created

Create the full skeleton for a new skill under `<skills-root>/<skill_name>/`.

* CREATE_SKILL_FILES << skill_name >> files_created
  * create `<skills-root>/<skill_name>/` directory
  * Read `templates/skill.md`
  * substitute `<skill-name>` with `skill_name`
  * write result to `<skills-root>/<skill_name>/skill.md`
  * Read `templates/ops.md`
  * substitute `<skill-name>` with `skill_name`
  * write result to `<skills-root>/<skill_name>/ops.md`
  * create subdirectories from `constants/skill-subdirs.md`
  * capture list of all written file paths into `files_created`
