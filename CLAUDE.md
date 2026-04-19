# CLAUDE.md — claude-canopy-examples

This repository contains example skills for [Canopy](https://github.com/kostiantyn-matsebora/claude-canopy) — a framework that turns Claude Code skills into executable programs rather than prose instructions.

## What this repo is

- **Purpose:** Working examples to learn from, copy, and adapt into your own projects.
- **Not a framework repo.** Framework changes belong in `claude-canopy`, not here.
- **Canopy subtree:** `.claude/canopy/` — files live natively in this repo's history. Never edit them directly; apply changes by updating the subtree.

## Directory layout

```
.claude/
├── canopy/                        <- git subtree (read-only; update via subtree pull)
│   └── docs/README.md             <- full Canopy reference (local copy)
├── rules/
│   └── skill-resources.md         <- active rules: category behavior, op lookup, tree syntax
└── skills/
    ├── shared/
    │   ├── project/ops.md         <- project-wide op definitions (add yours here)
    │   └── ops.md                 <- redirect stub
    ├── add-changelog-entry/
    ├── bump-version/
    ├── canopy-help/
    ├── generate-readme/
    ├── review-file/
    └── scaffold-skill/
```

## Canopy quick reference

> Full reference: `.claude/canopy/docs/README.md`

### Skill anatomy

Each skill lives under `.claude/skills/<skill-name>/` and contains:

| File/dir | Purpose |
|---|---|
| `skill.md` | Frontmatter + optional `## Agent` + `## Tree` + `## Rules` |
| `ops.md` | Skill-local op definitions (ALL_CAPS identifiers) |
| `schemas/` | Subagent output contracts |
| `templates/` | Fill `<token>` placeholders, write to target path |
| `commands/` | Shell scripts with named sections |
| `constants/` | Named values loaded into step context |
| `policies/` | Active rules enforced during execution |
| `verify/` | Post-run expected-state checklists |

### Op lookup order

1. `<skill>/ops.md` — skill-local
2. `.claude/skills/shared/project/ops.md` — project-wide
3. `.claude/canopy/skills/shared/framework/ops.md` — framework primitives (`IF`, `ELSE`, `ASK`, `SHOW_PLAN`, `VERIFY_EXPECTED`, …)

### Tree syntax (both forms are equivalent)

**Markdown list:**
```markdown
## Tree

* skill-name
  * SHOW_PLAN >> field1 | field2
  * ASK << Proceed? | Yes | No
  * IF << Yes
    * action
  * ELSE
    * Cancelled by user.
```

**Box-drawing:**
```
## Tree

\`\`\`
skill-name
├── SHOW_PLAN >> field1 | field2
├── ASK << Proceed? | Yes | No
├── IF << Yes
│   └── action
└── ELSE
    └── Cancelled by user.
\`\`\`
```

### Execution stages

1. **Initialize** — parse frontmatter + preamble, set context variables
2. **Explore** — run explore subagent if `## Agent` section exists; output captured via `schemas/explore-schema.json`
3. **Plan gate** — `SHOW_PLAN` → `ASK`; stop without changes on No
4. **Execute** — run tree nodes top-to-bottom; evaluate `IF`/`ELSE` branches
5. **Verify** — `VERIFY_EXPECTED` against checklist
6. **Respond** — emit declared output format

## Using the canopy agent

Invoke naturally in Claude Code:

| Goal | What to say |
|---|---|
| Create a skill | "Create a canopy skill that does X" |
| Scaffold blank | "Scaffold a blank skill called my-skill" |
| Modify | "Add a dry-run option to the deploy skill" |
| Validate | "Validate the bump-version skill" |
| Improve | "Improve the review-file skill" |
| Help | "What can the canopy agent do?" |

Every operation shows a plan and asks for confirmation before making changes.

## Available example skills

| Skill | Invoke by saying | Tree syntax used |
|---|---|---|
| `generate-readme` | "Generate or update the README for this project" | box-drawing |
| `add-changelog-entry` | "Add changelog entry for version 1.0.0" | box-drawing |
| `review-file` | "Review src/auth.py" | box-drawing |
| `scaffold-skill` | "Scaffold a new skill called my-skill" | markdown list |
| `bump-version` | "Bump version to 2.1.0" | markdown list |

## Adding a new example skill

1. Create `.claude/skills/<skill-name>/skill.md` and `ops.md`.
2. Add supporting resources in `schemas/`, `templates/`, etc. as needed.
3. Keep examples generic — avoid domain-specific internals.
4. Document the invocation in `README.md` if user-facing.

## Updating Canopy

Canopy lives at `.claude/canopy/` as a git subtree — its files are part of this repo's history. To pull in a newer version of the framework:

```bash
git subtree pull --prefix=.claude/canopy \
  https://github.com/kostiantyn-matsebora/claude-canopy master --squash
```

After pulling, re-run setup if new bundled skills or agents were added:

```bash
pwsh .claude/canopy/setup.ps1    # Windows
bash .claude/canopy/setup.sh     # Linux / macOS
```

## Commits

Follow [Conventional Commits](https://www.conventionalcommits.org/):
- `feat: add release-note generator example`
- `chore: update Canopy subtree to vX.Y.Z`
- `docs: clarify example skill invocations`
