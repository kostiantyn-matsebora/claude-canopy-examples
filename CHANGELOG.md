# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added

- **`parallel-review` example skill** — multi-aspect code review demonstrating the `PARALLEL` block primitive. Fans out four independent review subagents (security / performance / style / correctness) concurrently, each in its own context window, then merges findings into a unified severity-grouped report. **Requires canopy v0.19.0+** (PARALLEL primitive); the vendored framework will be bumped from 0.18.1 to 0.19.0 once the framework release ships.

### Notes

- This skill is the canonical example of the `PARALLEL` block primitive added in canopy v0.19.0. See the framework's [PRIMITIVES.md](https://github.com/kostiantyn-matsebora/claude-canopy/blob/master/docs/reference/PRIMITIVES.md) for the spec.

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
