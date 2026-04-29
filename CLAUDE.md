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

These two commands install all three framework skills as a single user-scope bundle. They become available as `/canopy:canopy` (authoring agent) and `/canopy:canopy-debug` (trace wrapper); `canopy-runtime` is hidden from the `/` menu.

Since canopy v0.18.0, **canopy-runtime self-activates on first load** — no separate `/canopy:canopy activate` step is needed. The runtime detects the platform and writes the marker block to this project's `CLAUDE.md` (or `.github/copilot-instructions.md` on Copilot) automatically when it first loads. If you ever want to force a re-write (e.g. after the marker block content changes in a new release), `/canopy:canopy activate` is still available.

To verify the install: open this repo in Claude Code and run `/canopy:canopy help` — you should see the canopy authoring agent's op reference.

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

### Skill anatomy (standard agentskills.io layout)

Each skill lives under `.claude/skills/<skill-name>/` and follows the standard layout — only `SKILL.md` (uppercase, exact spelling) at the root, with three top-level subdirectories:

| File / dir | Purpose |
|---|---|
| `SKILL.md` | agentskills.io frontmatter (`name`, `description`, `compatibility`, `metadata`) + safety preamble + optional `## Agent` + `## Tree` + `## Rules` + `## Response:` |
| `scripts/` | Executable scripts with named sections (was `commands/` in legacy layout) |
| `references/ops.md` or `references/ops/<name>.md` | Skill-local op definitions (ALL_CAPS identifiers); was `ops.md` at root in legacy layout |
| `references/<other>.md` | Supporting docs loaded on demand |
| `assets/templates/` | Fill `<token>` placeholders, write to target path |
| `assets/constants/` | Named values loaded into step context |
| `assets/schemas/` | Subagent output contracts |
| `assets/checklists/` | Evaluation criteria iterated by ops |
| `assets/policies/` | Active rules enforced during execution |
| `assets/verify/` | Post-run expected-state checklists |

Older skills using the flat layout (category dirs at the skill root) continue to work — canopy-runtime resolves `Read` references literally. `/canopy:canopy improve` can migrate them to the standard layout on user opt-in.

### Compatibility & safety preamble

Every skill with `## Tree` declares its canopy-runtime requirement via the `compatibility` frontmatter field, and opens its body with a runtime-required guard block before `$ARGUMENTS`. Both are inserted automatically by `/canopy:canopy create` and `/canopy:canopy scaffold`. They prevent silent wrong execution on agents without canopy-runtime active.

### Op lookup order

1. `<skill>/references/ops.md` or `<skill>/references/ops/<name>.md` — skill-local. Backward-compatible fallback: `<skill>/ops.md` at root for legacy-layout skills.
2. Consumer-defined cross-skill ops (optional; package as your own skill — declared via `compatibility` on dependents)
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

1. **Initialize** — parse frontmatter + safety preamble + preamble, set context variables
2. **Explore** — run explore subagent if `## Agent` section exists; output captured via `assets/schemas/explore-schema.json`
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
| Improve (incl. legacy → standard layout migration) | `/canopy:canopy improve review-file` |
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

1. Create `.claude/skills/<skill-name>/SKILL.md` (uppercase) with agentskills.io frontmatter (`name`, `description`, `compatibility`, `metadata`).
2. Open the body with the safety preamble guard block before `$ARGUMENTS`.
3. Add `references/ops.md` and supporting resources in `assets/schemas/`, `assets/templates/`, etc. as needed.
4. Keep examples generic — avoid domain-specific internals.
5. Document the invocation in `README.md` if user-facing.

Or just run `/canopy:canopy scaffold <skill-name>` — it creates the standard layout, frontmatter, compatibility field, and safety preamble automatically.

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

<!-- canopy-runtime-begin -->
## Canopy Runtime

Any `SKILL.md` under `.claude/skills/` or `.github/skills/` that declares a `## Tree`
section is a canopy-flavored skill. Before interpreting it, load
`<skills-root>/canopy-runtime/SKILL.md` and apply the execution model defined
there — sections (`## Agent`, `## Tree`, `## Rules`, `## Response:`), tree
notation (`<<`, `>>`, `|`), control-flow and interaction primitives, op lookup
chain (skill-local `references/ops.md` or `references/ops/<name>.md`, falling
back to legacy `ops.md` at root → consumer project ops → framework primitives),
category directory layout (`scripts/` for executable code, `references/` for
docs loaded on demand including ops, `assets/{templates,constants,schemas,
checklists,policies,verify}/` for static resources; legacy flat layout with
these dirs at skill root remains supported), subagent contract (`EXPLORE` as
first node when `## Agent` declares `**explore**`), and the active platform
runtime (`references/runtime-claude.md` or `references/runtime-copilot.md`).

`<skills-root>` resolves to `.claude/skills/` on Claude Code and `.github/skills/`
on Copilot.
<!-- canopy-runtime-end -->
