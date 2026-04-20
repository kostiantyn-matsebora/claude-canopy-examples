# generate-readme — Local Ops

Skill-specific ops. Highest priority in the three-level lookup order.

---

## MERGE_README \<\< context

```
MERGE_README << context
├── Read `README.md` for existing content and custom sections.
├── Read `templates/readme.md` to identify standard sections.
├── identify user-written custom sections (headings not in templates/readme.md)
├── regenerate all standard sections from context
├── re-insert custom sections at their original positions
└── write merged result to target_file
```

---

## CREATE_README \<\< context

```
CREATE_README << context
├── Read `templates/readme.md`
├── substitute all <token> placeholders from context
└── write populated template to target_file
```
