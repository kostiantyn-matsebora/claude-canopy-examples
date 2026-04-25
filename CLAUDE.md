# CLAUDE.md — claude-canopy-examples

This repository contains example skills for [Canopy](https://github.com/kostiantyn-matsebora/claude-canopy) — a framework that turns Claude Code skills into executable programs rather than prose instructions.

## What this repo is

- **Purpose:** Working examples to learn from, copy, and adapt into your own projects.
- **Not a framework repo.** Framework changes belong in `claude-canopy`, not here.
- **Canopy delivery in this repo:** Canopy is installed as a **Claude Code plugin** at user scope. The framework skills (`canopy`, `canopy-runtime`, `canopy-debug`) are NOT bundled in this repo — they live in the Claude Code plugin cache (`~/.claude/plugins/cache/claude-canopy/...`) once you've installed the plugin.

## One-time setup

Inside any Claude Code session, run:

```
/plugin marketplace add kostiantyn-matsebora/claude-canopy
/plugin install canopy@claude-canopy
```

That installs all three framework skills as a single bundle. They become available as `/canopy:canopy` (authoring agent) and `/canopy:canopy-debug` (trace wrapper); `canopy-runtime` is hidden from the `/` menu and loaded ambiently to interpret the example skills in this repo.

To verify the install: open this repo in Claude Code and run `/canopy:canopy help` — you should see the canopy authoring agent's op reference. If the command isn't found, the plugin install didn't take.

## Directory layout

```
.claude/skills/
├── add-changelog-entry/           <- example: add a CHANGELOG entry
├── bump-version/                  <- example: bump semantic versions
├── generate-readme/               <- example: generate or update README.md
├── review-file/                   <- example: structured code review
└── scaffold-skill/                <- example: scaffold a new skill skeleton
```

The framework itself is not in this tree — it comes from the plugin install above.

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
3. Framework primitives (`IF`, `ELSE`, `SWITCH`, `FOR_EACH`, `ASK`, `SHOW_PLAN`, `VERIFY_EXPECTED`, …) — defined in the plugin's `canopy-runtime/references/framework-ops.md`

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

## Using the canopy authoring agent

Invoke with `/canopy:canopy` (plugin-namespaced) in Claude Code:

| Goal | What to say |
|---|---|
| Create a skill | `/canopy:canopy create a skill that does X` |
| Scaffold blank | `/canopy:canopy scaffold my-skill` |
| Modify | `/canopy:canopy add a dry-run option to the deploy skill` |
| Validate | `/canopy:canopy validate bump-version` |
| Improve | `/canopy:canopy improve review-file` |
| Help | `/canopy:canopy help` |

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

Plugins update via Claude Code's own update mechanism:

```
/plugin update canopy@claude-canopy
```

Or remove and reinstall to pick up the latest:

```
/plugin uninstall canopy@claude-canopy
/plugin install canopy@claude-canopy
```

## Commits

Follow [Conventional Commits](https://www.conventionalcommits.org/):
- `feat: add release-note generator example`
- `chore: switch canopy install to plugin model`
- `docs: clarify example skill invocations`
