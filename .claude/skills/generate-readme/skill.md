---
name: generate-readme
description: Analyze the project structure and generate or update README.md. Covers purpose, prerequisites, installation, usage, and contributing sections. Preserves any custom sections the user has already written.
argument-hint: "[target-path]  (default: ./README.md)"
---

Generate or update README at: $ARGUMENTS (default: README.md)

---

## Agent

**explore** — reads the project root for: any existing README.md, package manifests (package.json, pyproject.toml, Cargo.toml, go.mod), top-level source directories, and .gitignore. Returns language, dependencies, entry points, and any existing README sections.

---

## Tree

```
generate-readme
├── EXPLORE >> context
├── SHOW_PLAN >> target_file | sections | detected_language | detected_deps
├── ASK << Proceed with generation? | Yes | No
├── IF << README already exists at target_file
│   └── MERGE_README << context
├── ELSE
│   └── CREATE_README << context
└── VERIFY_EXPECTED << verify/verify-expected.md
```

---

## Rules

- Read `policies/readme-rules.md` before writing any content
- Never overwrite custom sections the user has written — preserve them
- Keep code examples minimal but runnable

## Response: target_file | sections_written | sections_preserved
