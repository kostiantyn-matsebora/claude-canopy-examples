# CLAUDE.md — claude-canopy-examples

This repository is a self-contained playground for [Canopy](https://github.com/kostiantyn-matsebora/claude-canopy) — a framework that turns Claude Code and GitHub Copilot skills into executable programs rather than prose instructions.

## What this repo is

- **Purpose:** Working examples to clone, run, and adapt. The Canopy framework itself is vendored alongside the examples — clone the repo and the skills work in both Claude Code and GitHub Copilot without any extra install step.
- **Not a framework repo.** Framework changes belong in `claude-canopy`, not here.
- **Cross-client install:** Both the framework skills (`canopy-runtime`, `canopy`, `canopy-debug`) and the example skills live under `.agents/skills/` — the cross-client skills root that both Claude Code and GitHub Copilot read.

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

`.agents/skills/` is the cross-client root: Claude Code, GitHub Copilot, and other agentskills.io-compatible hosts all resolve skills from this single location.

## Canopy quick reference

> Full reference: [github.com/kostiantyn-matsebora/claude-canopy](https://github.com/kostiantyn-matsebora/claude-canopy)

### Skill anatomy (standard agentskills.io layout)

Each skill lives under `.agents/skills/<skill-name>/` and follows the standard layout — only `SKILL.md` (uppercase, exact spelling) at the root, with three top-level subdirectories:

| File / dir | Purpose |
|---|---|
| `SKILL.md` | agentskills.io frontmatter (`name`, `description`, `compatibility`, `metadata` — including `canopy-features` slice manifest and optional `canopy-contracts: strict`) + safety preamble + `## Tree` + `## Rules` + `## Response:` (plus the legacy `## Agent` section on pre-v0.20 skills — see "Subagent dispatch" below) |
| `scripts/` | Executable scripts with named sections (was `commands/` in legacy layout) |
| `references/ops.md` or `references/ops/<name>.md` | Skill-local op definitions (ALL_CAPS identifiers); was `ops.md` at root in legacy layout |
| `references/<other>.md` | Supporting docs loaded on demand |
| `assets/templates/` | Fill `<token>` placeholders, write to target path |
| `assets/constants/` | Named values loaded into step context |
| `assets/schemas/` | Op input/output contracts (subagent dispatch + universal contracts since v0.22.0+) |
| `assets/checklists/` | Evaluation criteria iterated by ops |
| `assets/policies/` | Active rules enforced during execution |
| `assets/verify/` | Post-run expected-state checklists |

Older skills using the flat layout (category dirs at the skill root) continue to work — canopy-runtime resolves `Read` references literally. `/canopy improve` can migrate them to the standard layout on user opt-in.

### Compatibility & safety preamble

Every skill with `## Tree` declares its canopy-runtime requirement via the `compatibility` frontmatter field, and opens its body with a runtime-required guard block before `$ARGUMENTS`. Both are inserted automatically by `/canopy create` and `/canopy scaffold`. They prevent silent wrong execution on agents without canopy-runtime active.

### Op lookup order

1. `<skill>/references/ops.md` or `<skill>/references/ops/<name>.md` — skill-local. Backward-compatible fallback: `<skill>/ops.md` at root for legacy-layout skills.
2. Consumer-defined cross-skill ops (optional; package as your own skill — declared via `compatibility` on dependents)
3. Framework primitives (`IF`, `ELSE_IF`, `ELSE`, `SWITCH`, `CASE`, `DEFAULT`, `FOR_EACH`, `PARALLEL`, `BREAK`, `END`, `ASK`, `SHOW_PLAN`, `EXPLORE`, `VERIFY_EXPECTED`) — index at `.agents/skills/canopy-runtime/references/ops.md`; per-feature slice files under `references/ops/<slice>.md` (sliced in v0.21.0; the runtime lazy-loads only the slices declared in each skill's `metadata.canopy-features`)

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

### Subagent dispatch

Per-op since v0.20.0 — an op definition declares dispatch via a `> **Subagent.**` blockquote marker; call sites bold the op name:

```markdown
## REVIEW_ASPECT << aspect | files >> findings

> **Subagent.** Output contract: `assets/schemas/aspect-findings.json`
```

```markdown
* PARALLEL
  * **REVIEW_ASPECT** << "security" | context.files >> security_findings
  * **REVIEW_ASPECT** << "style"    | context.files >> style_findings
```

The legacy `## Agent` singular section is still supported (treated as a single-element marked op named `EXPLORE`) — see `parallel-review` for the marker form, `bump-version` / `review-file` / `add-changelog-entry` / `generate-readme` for the legacy form.

### Universal op contracts (v0.22.0+)

Any op (inline or subagent) may declare typed JSON Schema input/output contracts via blockquote markers. Skills opt into runtime enforcement via `metadata.canopy-contracts: strict`. See `parallel-review` for the canonical demo.

### Execution stages

1. **Initialize** — parse frontmatter (incl. `metadata.canopy-features` slice manifest + optional `metadata.canopy-contracts`) + safety preamble, set context variables
2. **Load runtime spec** — canopy-runtime loads only the slices declared in `metadata.canopy-features` (manifest absent → load every slice for back-compat)
3. **Subagent dispatch** — when the tree opens with a bold-marked op call (or the legacy `## Agent` section), the runtime dispatches it out-of-context; output captured into context per the op's `Output contract`
4. **Plan gate** — `SHOW_PLAN` → `ASK`; stop without changes on No
5. **Execute** — run tree nodes top-to-bottom; evaluate `IF`/`ELSE_IF`/`ELSE`/`SWITCH`/`CASE`/`FOR_EACH`/`PARALLEL`; bold call sites dispatch out-of-context per op-def marker; under `metadata.canopy-contracts: strict`, validate each contract-bearing op's input/output and halt with `[contract-violation]` on drift
6. **Verify** — `VERIFY_EXPECTED` against checklist
7. **Respond** — emit declared output format

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
| `parallel-review` | "Run a parallel review on src/" | box-drawing |

## Feature coverage matrix

This repo's job is to demonstrate every capability of the Canopy framework with at least one working skill. Maintain this matrix when canopy ships a feature — see [`.claude/rules/feature-coverage.md`](.claude/rules/feature-coverage.md) for the full rule.

| Feature | bump-version | scaffold-skill | parallel-review | review-file | add-changelog-entry | generate-readme |
|---|:---:|:---:|:---:|:---:|:---:|:---:|
| `metadata.canopy-features` manifest (v0.21+) | ✓ | ✓ | ✓ | ✓ | · | · |
| `IF` / `ELSE_IF` / `ELSE` | ✓ | ✓ | ✓ |  | ✓ |  |
| `SWITCH` / `CASE` / `DEFAULT` | ✓ |  |  |  |  |  |
| `FOR_EACH` |  |  | ✓ (in ops) |  |  |  |
| `PARALLEL` (v0.19+) |  |  | ✓ |  |  |  |
| `BREAK` |  |  |  |  |  |  |
| `END` (halt with message) | ✓ | ✓ | ✓ |  |  |  |
| `ASK` (multi-choice + free-form) | ✓ | ✓ | ✓ |  |  |  |
| `SHOW_PLAN` | ✓ | ✓ | ✓ |  |  |  |
| `VERIFY_EXPECTED` | ✓ | ✓ | ✓ |  |  |  |
| `## Agent` + `**explore**` (legacy soft-compat) |  |  |  |  |  |  |
| Subagent dispatch via `**OP_NAME**` + marker (v0.20+) | ✓ |  | ✓ | ✓ |  | ✓ |
| Universal op contracts (`> **Input/Output contract:**`, v0.22+) |  |  | ✓ |  |  |  |
| `metadata.canopy-contracts: strict` (v0.22+) |  |  | ✓ |  |  |  |
| `## Rules` | ✓ | ✓ | ✓ |  |  |  |
| `## Response:` | ✓ | ✓ | ✓ |  |  |  |
| `bind` (variable assignment) |  |  |  |  |  |  |
| `Read \`category/file\`` resource refs | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |
| `assets/schemas/` (output contracts) |  |  | ✓ | ✓ | ✓ | ✓ |
| `assets/templates/` (token placeholders) | ✓ | ✓ | ✓ |  |  | ✓ |
| `assets/constants/` (lookup tables) |  | ✓ | ✓ |  |  |  |
| `assets/policies/` |  |  |  |  |  |  |
| `assets/checklists/` |  |  |  |  |  |  |
| `assets/verify/` (expected state) | ✓ | ✓ | ✓ |  |  |  |
| `scripts/` (executable code) | ✓ |  |  |  |  |  |
| Box-drawing tree syntax | | | ✓ | ✓ | ✓ | ✓ |
| Markdown-list tree syntax | ✓ | ✓ | | | | |

**Manifest column legend:** ✓ — declares `metadata.canopy-features` (lazy-loads only the named primitive slices). · — intentionally omitted to demonstrate v0.21.0's back-compat path: pre-v0.21.0 skills that never declared a manifest still execute correctly; the runtime falls back to loading every slice. `add-changelog-entry` and `generate-readme` carry the · marker on purpose so authors browsing this repo see both shapes side-by-side.

**`## Agent` row is intentionally empty.** Pre-v0.20 skills declared a single explore subagent via the top-level `## Agent` section. Since v0.20 the canonical form is per-op marker dispatch (`> **Subagent.**` op-def marker + bold `**OP_NAME**` call site), and as of v0.9.0 of this repo every subagent-using example uses the marker form. The framework still supports the legacy `## Agent` form as soft-compat so older skills in the wild continue to execute, but new authors should not learn it from this repo's demos. Soft-compat coverage lives in the framework's own `docs/TEST_SCENARIOS.md`, not here.

**Coverage gaps to close** (no skill currently demos these; track as candidates for future examples):
- `BREAK` (early-exit a `FOR_EACH` loop)
- `bind` (named variable assignment)
- `assets/policies/` and `assets/checklists/` resource categories

## Adding a new example skill

1. Create `.agents/skills/<skill-name>/SKILL.md` (uppercase) with agentskills.io frontmatter (`name`, `description`, `compatibility`, `metadata`).
2. Open the body with the safety preamble guard block before `$ARGUMENTS`.
3. Add `references/ops.md` and supporting resources in `assets/schemas/`, `assets/templates/`, etc. as needed.
4. Keep examples generic — avoid domain-specific internals.
5. Document the invocation in `README.md` if user-facing.
6. **Update the feature coverage matrix above** — add a column for the new skill, mark which features it demonstrates. Cross-check the gaps list and remove any that are now covered.

Or just run `/canopy scaffold <skill-name>` — it creates the standard layout, frontmatter, compatibility field, and safety preamble automatically.

## Commits

Follow [Conventional Commits](https://www.conventionalcommits.org/):
- `feat: add release-note generator example`
- `chore: bump canopy framework to v0.18.2`
- `docs: clarify example skill invocations`

<!-- canopy-runtime-begin -->
<!-- canopy-runtime-begin -->
## Canopy Runtime

Any `SKILL.md` declaring a `## Tree` section is canopy-flavored. To interpret, load `<skills-root>/canopy-runtime/SKILL.md` (where `<skills-root>` is the first match of `.agents/skills/`, `.claude/skills/`, `.github/skills/`). The runtime SKILL.md handles platform detection, op lookup, and lazy-loads only the spec slices the skill actually uses (per `metadata.canopy-features`).
<!-- canopy-runtime-end -->
<!-- canopy-runtime-end -->
