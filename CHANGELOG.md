# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.7.0] — 2026-05-09

Bundles two framework syncs: **v0.20.0** (subagent dispatch model — per-op markers + bold call-sites; `parallel-review` retrofitted as the canonical example) and **v0.21.0** (sliced primitive spec + per-skill `metadata.canopy-features` manifest; mixed retrofit demonstrating both annotation paths).

### Added (v0.21.0 sync)

- **`metadata.canopy-features` manifests** added to four example skills declaring which primitive families each one uses. The runtime lazy-loads only the named slices (per the v0.21.0 spec):

  | Skill | Manifest |
  |---|---|
  | `bump-version` | `[interaction, control-flow, verify, explore]` |
  | `scaffold-skill` | `[interaction, control-flow, verify]` |
  | `parallel-review` | `[interaction, control-flow, parallel, subagent, verify]` |
  | `review-file` | `[interaction, control-flow, explore]` |
  | `add-changelog-entry` | *intentionally omitted (back-compat demo)* |
  | `generate-readme` | *intentionally omitted (back-compat demo)* |

- **Mixed retrofit shape** — `add-changelog-entry` and `generate-readme` are deliberately left without manifests so authors browsing this repo see both v0.21.0 paths side-by-side: explicit-declaration on most skills, and the v0.21.0 promise that pre-existing skills still execute correctly with no manifest at all (the runtime falls back to loading every slice).
- **`metadata.canopy-features` row** added to the `CLAUDE.md` Feature coverage matrix, with a legend explaining the · marker on the two intentionally-undeclared skills.

### Changed (v0.21.0 sync)

- **Vendored framework bumped to v0.21.0.** `canopy-runtime`, `canopy`, `canopy-debug` re-installed via `gh skill install --pin v0.21.0`.
- **`.canopy-version`** → `0.21.0`.
- **Slim canopy-runtime marker block** — `CLAUDE.md` and `.github/copilot-instructions.md` updated to the v0.21.0 5-line trigger + pointer block (down from ~30 lines). The runtime spec (primitives, lookup chain, category layout) is now lazy-loaded only when canopy-runtime is actually engaged, instead of every session paying for it ambiently.

### Changed (v0.20.0 sync — held over from prior cycle)

- **`parallel-review` retrofitted to subagent dispatch model** (`.agents/skills/parallel-review/`):
  - **`SKILL.md`** — `## Agent` section dropped. The four prose subagent invocations under `PARALLEL` become four bold-marked op calls: `**REVIEW_ASPECT** << aspect | context.files >> <findings_var>`. The first tree node becomes `**EXPLORE_TARGET** << $ARGUMENTS >> context` — explicit subagent dispatch instead of the legacy `## Agent` + `EXPLORE` sugar.
  - **`references/ops.md`** — adds two subagent op definitions, each carrying the `> **Subagent.** Output contract: \`<schema>\`` marker:
    - `## EXPLORE_TARGET << target_path >> context` — pointing at `assets/schemas/explore-schema.json`
    - `## REVIEW_ASPECT << aspect | files >> findings` — pointing at `assets/schemas/aspect-findings-schema.json`
  - `MERGE_ASPECT_FINDINGS` and `REPORT_BY_SEVERITY` stay as inline ops (no marker) — they aggregate already-collected findings and don't benefit from context isolation.
  - Schema files unchanged.
- **`compatibility` field on `parallel-review`** — declares the v0.20.0+ runtime requirement (subagent dispatch model).

### Notes

- The `parallel-review` retrofit is the canonical example of the **subagent dispatch model** introduced in canopy v0.20.0 — each parallel child is a marker-anchored subagent call, not a prose instruction. PARALLEL composes naturally with marker-based dispatch.
- The mixed manifest retrofit is the canonical demonstration of the **per-skill slice manifest** introduced in canopy v0.21.0. Open the same example repo in vscode with the canopy-skills extension v0.14.0+ installed: the four annotated skills pass cleanly; `add-changelog-entry` and `generate-readme` surface the "manifest absent" warning (Warning, not Error — back-compat preserved).

## [0.6.0] — 2026-05-09

Sync to canopy v0.19.0. Adds a new example skill demonstrating the `PARALLEL` block primitive.

### Added

- **`parallel-review` example skill** (`.agents/skills/parallel-review/`) — multi-aspect code review demonstrating the `PARALLEL` block primitive. Fans out four independent review subagents (security / performance / style / correctness) concurrently, each in its own context window, then merges findings into a unified severity-grouped report. The canonical example of `PARALLEL` in real use.

### Changed

- **Vendored framework bumped from v0.18.1 → v0.19.0** (`canopy-runtime`, `canopy`, `canopy-debug` re-installed via `gh skill install --pin v0.19.0`). The framework now includes the `PARALLEL` primitive (semantic spec in `framework-ops.md`, deterministic emission rules in `runtime-claude.md` / `runtime-copilot.md`, marker-block updated, authoring-skill ops aware of the migration target).
- **`.canopy-version`** → `0.19.0`.

### Notes

- The `parallel-review` skill is the canonical example of the `PARALLEL` block primitive added in canopy v0.19.0. See the framework's [PRIMITIVES.md](https://github.com/kostiantyn-matsebora/claude-canopy/blob/master/docs/reference/PRIMITIVES.md) for the spec.
- Existing example skills (`add-changelog-entry`, `bump-version`, `generate-readme`, `review-file`, `scaffold-skill`) are unchanged — `PARALLEL` is opt-in; prose-driven subagent invocation continues to work.

## [0.5.1] - 2026-04-30

### Fixed

- **`scaffold-skill` verify-expected paths.** `.agents/skills/scaffold-skill/assets/verify/verify-expected.md` checked for stale paths (`skill.md` lowercase, `commands/` subdir) that the op never produces — every clean scaffold would have failed `VERIFY_EXPECTED`. Updated to check the standard agentskills.io layout (`SKILL.md` uppercase, `scripts/`, `references/`, `assets/{templates,constants,schemas,checklists,policies,verify}/`) — matches what `CREATE_SKILL_FILES` actually writes.
- **`bump-version` CHANGELOG idempotency.** `BUMP_CHANGELOG` unconditionally prepended a new `## [version]` block, so the documented `add-changelog-entry <v>` → `bump-version <v>` sequence produced two duplicate entries for the same version. The op now skips when a heading for the target version already exists. `bump-version`'s `verify-expected.md` updated to allow either source for the entry.

## [0.5.0] - 2026-04-30

**Sync with Canopy framework `v0.18.1`.** Repository converted into a self-contained, cross-client playground: framework + examples both vendored under `.agents/skills/`, no plugin install required. All five example skills migrated to the agentskills.io standard layout with spec-compliant `compatibility` frontmatter and structured safety preamble.

### Changed

- **Moved all skills to `.agents/skills/`** — the cross-client skills root recognized by canopy-runtime v0.18.1+ on both Claude Code and GitHub Copilot.
  - **Was** — `.claude/skills/<skill>/` (Claude-only) plus duplicated copies under `.github/skills/<skill>/` (Copilot).
  - **Now** — single `.agents/skills/<skill>/` location resolved by both clients. First-match-wins resolution falls back to `.claude/skills/` and `.github/skills/`, so the layout stays compatible with consumers on older runtimes.
- **Vendored the Canopy framework** at `.agents/skills/canopy-runtime/`, `canopy/`, `canopy-debug/` (pinned to v0.18.1 via `gh skill install --dir .agents/skills --pin v0.18.1`).
  - **Why** — `git clone` is now sufficient to use the repo. No `/plugin install canopy@claude-canopy` step.
  - **Updating** — re-run `gh skill install --pin vX.Y.Z` for each framework skill, then bump `.canopy-version`.
- **Migrated all five example skills to canonical agentskills.io layout.** Affects `add-changelog-entry`, `bump-version`, `generate-readme`, `review-file`, `scaffold-skill`.
  - **Skill root** — only `SKILL.md` at the skill root.
  - **Ops** — moved to `references/ops.md`.
  - **Static resources** — moved to `assets/{templates,constants,schemas,policies,verify}/`.
  - **Executable code** — moved to `scripts/` (was `commands/`).
  - **Backward compatibility** — flat-layout skills authored elsewhere continue to work; canopy-runtime resolves `Read` references literally.
- **Added `compatibility` field to every skill.**
  - **Form** — free-text per agentskills.io spec.
  - **Content** — declares the canopy-runtime requirement and names the source repo.
  - **Install tools** — listed as alternatives (`gh skill install`, `git clone`, install scripts, plugin marketplace) so the agent picks based on its environment.
- **Added structured safety preamble** at the top of every skill body.
  - **Form** — labeled bullets (not stream-of-consciousness prose).
  - **Detection** — canopy-runtime under `<skills-root>/`, or marker block in the instructions file.
  - **Fail mode** — halts execution on agents without canopy-runtime active.
- **Updated `CLAUDE.md` and `.github/copilot-instructions.md`** to the canonical canopy-runtime v0.18.1 marker block (lists all three skills roots in the new resolution order: `.agents/skills/` → `.claude/skills/` → `.github/skills/`).
- **Rewrote install docs.**
  - **`README.md` / `CLAUDE.md` / `CONTRIBUTING.md`** — describe the vendored, clone-and-go workflow on both clients. Plugin-install section removed.

## [0.4.0] - 2026-04-12

### Fixed

- Update skill invocation examples in README to include links

### Changed

- Bump canopy submodule to latest sanitized master
- Update canopy submodule to latest commit

## [0.1.0] - 2026-04-12

### Added

- Add claude-canopy as a git submodule at `.claude/canopy` with setup scripts for Windows (ps1) and Linux/macOS (sh)
- Add `generate-readme` example skill — analyzes project structure and generates or updates README.md
- Add `add-changelog-entry` example skill — reads git commits since last tag and prepends a Keep a Changelog entry
- Add `review-file` example skill — performs structured code review grouped by severity with suggested fixes
- Add README.md with project overview, prerequisites, installation, usage, and contributing sections
- Fix skill discovery for bundled canopy skills by creating directory junctions/symlinks in `.claude/skills/`

## [0.3.0] - 2026-04-12

### Added

- `scaffold-skill` example — generates a new Canopy skill skeleton; demonstrates markdown list tree syntax (`*` nested lists) with no branching
- `bump-version` example — bumps semver across version-bearing files and prepends a CHANGELOG entry; demonstrates markdown list syntax with nested `IF`/`ELSE` branches, explore subagent, and `VERIFY_EXPECTED`
- README: usage table updated with new skills; Tree syntax section added showing both markdown list and box-drawing formats side-by-side

## [0.2.0] - 2026-04-12

### Added

- `canopy-skill` agent available via submodule update — handles CREATE, MODIFY, SCAFFOLD, CONVERT_TO_CANOPY, VALIDATE, and CONVERT_TO_REGULAR operations
- `.claude/agents/canopy-skill.md` and `.claude/agents/canopy-skill/` wired by setup script

### Changed

- Submodule `.claude/canopy` updated to `d6bd2d7` (canopy v0.5.0)
- README: Prerequisites broadened from VS Code + GitHub Copilot Chat to any Claude Code-compatible assistant (Claude Code CLI, VS Code extensions, etc.); usage section phrasing made tool-agnostic

[0.5.1]: https://github.com/kostiantyn-matsebora/claude-canopy-examples/compare/v0.5.0...v0.5.1
[0.5.0]: https://github.com/kostiantyn-matsebora/claude-canopy-examples/compare/v0.4.0...v0.5.0
[0.4.0]: https://github.com/kostiantyn-matsebora/claude-canopy-examples/compare/v0.3.0...v0.4.0
[0.3.0]: https://github.com/kostiantyn-matsebora/claude-canopy-examples/compare/v0.2.0...v0.3.0
[0.2.0]: https://github.com/kostiantyn-matsebora/claude-canopy-examples/compare/v0.1.0...v0.2.0
[0.1.0]: https://github.com/kostiantyn-matsebora/claude-canopy-examples/releases/tag/v0.1.0
