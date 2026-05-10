# generate-readme — Local Ops

Skill-specific ops. Highest priority in the three-level lookup order.

---

## EXPLORE >> context

> **Subagent.** Output contract: `assets/schemas/explore-schema.json`

* EXPLORE >> context
  * Detect any existing `README.md` at the target path
  * Detect package manifests — see `assets/constants/package-manifests.md`
  * Detect top-level source directories
  * Detect `.gitignore` presence
  * Return a context object matching `assets/schemas/explore-schema.json`

---

## MERGE_README \<\< context

```
MERGE_README << context
├── Read `README.md` for existing content and custom sections.
├── Read `assets/templates/readme.md` to identify standard sections.
├── identify user-written custom sections (headings not in assets/templates/readme.md)
├── regenerate all standard sections from context
├── re-insert custom sections at their original positions
└── write merged result to target_file
```

---

## CREATE_README \<\< context

```
CREATE_README << context
├── Read `assets/templates/readme.md`
├── substitute all <token> placeholders from context
└── write populated template to target_file
```
