---
name: generate-readme
description: Analyze the project structure and generate or update README.md. Covers purpose, prerequisites, installation, usage, and contributing sections. Preserves any custom sections the user has already written.
argument-hint: "[target-path]  (default: ./README.md)"
---

Generate or update README at: $ARGUMENTS (default: README.md)

---

## Agent

**explore** — reads the project root to populate the README context. Output contract: `schemas/explore-schema.json`.

Sub-tasks:
- Detect any existing `README.md` at the target path
- Detect package manifests — see `constants/package-manifests.md`
- Detect top-level source directories
- Detect `.gitignore` presence

---

## Tree

```
generate-readme
├── EXPLORE >> context
├── SHOW_PLAN >> target_file | sections | detected_language | detected_deps
├── ASK << Proceed with generation? | Yes | No
├── IF << user chose No
│   └── END Cancelled.
├── Read `policies/readme-rules.md` for content and preservation rules.
├── IF << README already exists at target_file
│   └── MERGE_README << context
├── ELSE
│   └── CREATE_README << context
└── VERIFY_EXPECTED << verify/verify-expected.md
```

---

## Rules

- Never overwrite custom sections the user has written — preserve them
- Keep code examples minimal but runnable

## Response: target_file | sections_written | sections_preserved
