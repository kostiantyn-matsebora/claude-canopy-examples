# CLAUDE.md — claude-canopy-examples

This repository contains example skills for [Canopy](https://github.com/kostiantyn-matsebora/claude-canopy) — a framework that turns Claude Code skills into executable programs rather than prose instructions.

## What this repo is

- **Purpose:** Working examples to learn from, copy, and adapt into your own projects.
- **Not a framework repo.** Framework changes belong in `claude-canopy`, not here.
- **Canopy delivery:** Canopy ships as three [agentskills.io](https://agentskills.io)-format Agent Skills — `canopy-runtime` (execution engine, minimum install), `canopy` (authoring agent, provides `/canopy`), `canopy-debug` (trace wrapper). Installed via `install.sh` / `install.ps1` (recommended — also writes ambient `CLAUDE.md` block) or `gh skill install` (GitHub CLI v2.90.0+). No more git subtree, no more setup scripts.

## Directory layout

```
.claude/skills/
├── canopy-runtime/                <- execution engine (platform rules, primitives, category semantics); hidden from / menu
├── canopy/                        <- /canopy authoring agent (run /canopy help for ops reference)
├── canopy-debug/                  <- /canopy-debug trace wrapper
├── add-changelog-entry/           <- example: add a CHANGELOG entry
├── bump-version/                  <- example: bump semantic versions
├── generate-readme/               <- example: generate or update README.md
├── review-file/                   <- example: structured code review
└── scaffold-skill/                <- example: scaffold a new skill skeleton
```

`CLAUDE.md` at the repo root contains a `<!-- canopy-runtime-begin -->` marker block (written by the install script) that ambiently activates `canopy-runtime` for every session. User skills stay runtime-unaware.

## Canopy quick reference

> Full reference: [github.com/kostiantyn-matsebora/claude-canopy](https://github.com/kostiantyn-matsebora/claude-canopy)

### Skill anatomy

Each skill lives under `.claude/skills/<skill-name>/` and contains:

| File/dir | Purpose |
|---|---|
| `SKILL.md` | agentskills.io frontmatter (`name`, `description`) + optional `## Agent` + `## Tree` + `## Rules` |
| `ops.md` | Skill-local op definitions (ALL_CAPS identifiers) |
| `schemas/` | Subagent output contracts |
| `templates/` | Fill `<token>` placeholders, write to target path |
| `commands/` | Shell scripts with named sections |
| `constants/` | Named values loaded into step context |
| `policies/` | Active rules enforced during execution |
| `verify/` | Post-run expected-state checklists |
| `references/` | Supporting docs loaded on demand |

### Op lookup order

1. `<skill>/ops.md` — skill-local
2. Consumer-defined cross-skill ops (optional; package as your own skill — no built-in location)
3. `.claude/skills/canopy-runtime/references/framework-ops.md` — framework primitives (`IF`, `ELSE`, `SWITCH`, `FOR_EACH`, `ASK`, `SHOW_PLAN`, `VERIFY_EXPECTED`, …)

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

Invoke with `/canopy` (or natural language) in Claude Code:

| Goal | What to say |
|---|---|
| Create a skill | `/canopy create a skill that does X` |
| Scaffold blank | `/canopy scaffold my-skill` |
| Modify | `/canopy add a dry-run option to the deploy skill` |
| Validate | `/canopy validate bump-version` |
| Improve | `/canopy improve review-file` |
| Help | `/canopy help` |

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

1. Create `.claude/skills/<skill-name>/SKILL.md` with agentskills.io frontmatter (`name`, `description`).
2. Add `ops.md` and supporting resources in `schemas/`, `templates/`, etc. as needed.
3. Keep examples generic — avoid domain-specific internals.
4. Document the invocation in `README.md` if user-facing.

## Updating Canopy

Easiest path — re-run the install script, which updates all three skills AND the CLAUDE.md marker block idempotently:

```bash
curl -sSL https://raw.githubusercontent.com/kostiantyn-matsebora/claude-canopy/master/install.sh | bash -s -- --version 0.18.0
```

Or per-skill via `gh skill` (does NOT update CLAUDE.md marker block):

```bash
gh skill update kostiantyn-matsebora/claude-canopy canopy-runtime --pin v0.18.0
gh skill update kostiantyn-matsebora/claude-canopy canopy         --pin v0.18.0
gh skill update kostiantyn-matsebora/claude-canopy canopy-debug   --pin v0.18.0
```

## Commits

Follow [Conventional Commits](https://www.conventionalcommits.org/):
- `feat: add release-note generator example`
- `chore: update canopy skills to vX.Y.Z`
- `docs: clarify example skill invocations`
