# CLAUDE.md — claude-canopy-examples

This repository is a self-contained playground for [Canopy](https://github.com/kostiantyn-matsebora/claude-canopy) — a framework that turns Claude Code and GitHub Copilot skills into executable programs rather than prose instructions.

## What this repo is

- **Purpose:** Working examples to clone, run, and adapt. The Canopy framework itself is vendored alongside the examples — clone the repo and the skills work in both Claude Code and GitHub Copilot without any extra install step.
- **Not a framework repo.** Framework changes belong in `claude-canopy`, not here.
- **Cross-client install:** Both the framework skills (`canopy-runtime`, `canopy`, `canopy-debug`) and the example skills live under `.agents/skills/` — the cross-client skills root recognized by canopy-runtime v0.18.1+ on both Claude Code and GitHub Copilot.

## One-time setup

```bash
git clone https://github.com/kostiantyn-matsebora/claude-canopy-examples
cd claude-canopy-examples
```

That's it. Open the repo in Claude Code or VS Code with GitHub Copilot — the canopy-runtime marker block is committed to `CLAUDE.md` and `.github/copilot-instructions.md`, so the runtime auto-loads on first agent invocation.

The framework skills become available as:

| Slash command | Skill |
|---|---|
| `/canopy` | authoring agent (create / modify / validate / improve / scaffold) |
| `/canopy-debug` | trace wrapper for any canopy-flavored skill |

`canopy-runtime` is hidden from the `/` menu (`metadata.user-invocable: "false"`) and loaded ambiently.

To verify: open this repo and run `/canopy help` — you should see the canopy authoring agent's op reference.

## Updating Canopy

The framework skills are vendored via [`gh skill install`](https://cli.github.com/manual/gh_skill_install) (requires GitHub CLI 2.91+). To upgrade to a new release:

```bash
gh skill install kostiantyn-matsebora/claude-canopy canopy-runtime --dir .agents/skills --pin vX.Y.Z
gh skill install kostiantyn-matsebora/claude-canopy canopy         --dir .agents/skills --pin vX.Y.Z
gh skill install kostiantyn-matsebora/claude-canopy canopy-debug   --dir .agents/skills --pin vX.Y.Z
```

Then bump `.canopy-version` to match and commit. The pinned tag is captured in each `SKILL.md`'s `metadata.version`.

## Directory layout

```
.agents/skills/
├── canopy-runtime/                <- framework: execution engine (vendored)
├── canopy/                        <- framework: authoring agent (vendored)
├── canopy-debug/                  <- framework: trace wrapper (vendored)
├── add-changelog-entry/           <- example: add a CHANGELOG entry
├── bump-version/                  <- example: bump semantic versions
├── generate-readme/               <- example: generate or update README.md
├── review-file/                   <- example: structured code review
└── scaffold-skill/                <- example: scaffold a new skill skeleton
```

`.agents/skills/` is the cross-client root: Claude Code, GitHub Copilot, and other agentskills.io-compatible hosts all resolve skills from this single location (canopy v0.18.1+).

## Canopy quick reference

> Full reference: [github.com/kostiantyn-matsebora/claude-canopy](https://github.com/kostiantyn-matsebora/claude-canopy)

### Skill anatomy (standard agentskills.io layout)

Each skill lives under `.agents/skills/<skill-name>/` and follows the standard layout — only `SKILL.md` (uppercase, exact spelling) at the root, with three top-level subdirectories:

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

Older skills using the flat layout (category dirs at the skill root) continue to work — canopy-runtime resolves `Read` references literally. `/canopy improve` can migrate them to the standard layout on user opt-in.

### Compatibility & safety preamble

Every skill with `## Tree` declares its canopy-runtime requirement via the `compatibility` frontmatter field, and opens its body with a runtime-required guard block before `$ARGUMENTS`. Both are inserted automatically by `/canopy create` and `/canopy scaffold`. They prevent silent wrong execution on agents without canopy-runtime active.

### Op lookup order

1. `<skill>/references/ops.md` or `<skill>/references/ops/<name>.md` — skill-local. Backward-compatible fallback: `<skill>/ops.md` at root for legacy-layout skills.
2. Consumer-defined cross-skill ops (optional; package as your own skill — declared via `compatibility` on dependents)
3. Framework primitives (`IF`, `ELSE`, `SWITCH`, `FOR_EACH`, `ASK`, `SHOW_PLAN`, `VERIFY_EXPECTED`, …) — defined in `.agents/skills/canopy-runtime/references/framework-ops.md`

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

Invoke with `/canopy` in Claude Code or GitHub Copilot:

| Goal | What to say |
|---|---|
| Create a skill | `/canopy create a skill that does X` |
| Scaffold blank | `/canopy scaffold my-skill` |
| Modify | `/canopy add a dry-run option to the deploy skill` |
| Validate | `/canopy validate bump-version` |
| Improve (incl. legacy → standard layout migration) | `/canopy improve review-file` |
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

1. Create `.agents/skills/<skill-name>/SKILL.md` (uppercase) with agentskills.io frontmatter (`name`, `description`, `compatibility`, `metadata`).
2. Open the body with the safety preamble guard block before `$ARGUMENTS`.
3. Add `references/ops.md` and supporting resources in `assets/schemas/`, `assets/templates/`, etc. as needed.
4. Keep examples generic — avoid domain-specific internals.
5. Document the invocation in `README.md` if user-facing.

Or just run `/canopy scaffold <skill-name>` — it creates the standard layout, frontmatter, compatibility field, and safety preamble automatically.

## Commits

Follow [Conventional Commits](https://www.conventionalcommits.org/):
- `feat: add release-note generator example`
- `chore: bump canopy framework to v0.18.2`
- `docs: clarify example skill invocations`

<!-- canopy-runtime-begin -->
## Canopy Runtime

**Trigger:** any `SKILL.md` declaring a `## Tree` section is a canopy-flavored skill. Before interpreting it, load `<skills-root>/canopy-runtime/SKILL.md` and apply its execution model.

- **`<skills-root>` resolution** — first match wins:
  - `.agents/skills/` — cross-agent install (gh skill install default on Copilot and other hosts)
  - `.claude/skills/` — Claude Code
  - `.github/skills/` — GitHub Copilot
- **Platform detection** — at runtime, the agent self-identifies the active host:
  - Claude Code → apply `<skills-root>/canopy-runtime/references/runtime-claude.md`
  - GitHub Copilot → apply `<skills-root>/canopy-runtime/references/runtime-copilot.md`
  - Other hosts → halt with unsupported-platform error
- **Sections** — `## Agent`, `## Tree`, `## Rules`, `## Response:`
- **Tree notation** — `<<` input, `>>` output, `|` separator
- **Primitives** (defined in canopy-runtime's `references/framework-ops.md`):
  - control flow — `IF`, `ELSE_IF`, `ELSE`, `SWITCH`, `CASE`, `DEFAULT`, `FOR_EACH`, `BREAK`, `END`
  - interaction — `ASK`, `SHOW_PLAN`
  - execution — `EXPLORE`, `VERIFY_EXPECTED`
- **Op lookup chain** — first match wins:
  - skill-local: `<skill>/references/ops.md` or `<skill>/references/ops/<name>.md` (legacy `<skill>/ops.md` at root also supported)
  - consumer-defined cross-skill ops, if any
  - framework primitives in canopy-runtime's `references/framework-ops.md`
- **Category layout** (under each skill):
  - `scripts/` — executable code
  - `references/` — docs loaded on demand (including ops)
  - `assets/{templates,constants,schemas,checklists,policies,verify}/` — static resources
  - Legacy flat layout (these dirs at skill root) remains supported.
- **Subagent contract** — `EXPLORE` is the first tree node when `## Agent` declares `**explore**`.
<!-- canopy-runtime-end -->
