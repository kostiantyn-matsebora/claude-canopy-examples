# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.5.0] - 2026-04-30

**Sync with Canopy framework `v0.18.0`.** All five example skills migrated to the agentskills.io standard layout, with spec-compliant `compatibility` frontmatter and the structured safety preamble.

### Changed

- **Migrated all five skills to canonical agentskills.io layout.** Affects `add-changelog-entry`, `bump-version`, `generate-readme`, `review-file`, `scaffold-skill`.
  - **Skill root** — only `SKILL.md` at the skill root.
  - **Ops** — moved to `references/ops.md`.
  - **Static resources** — moved to `assets/{templates,constants,schemas,policies,verify}/`.
  - **Executable code** — moved to `scripts/` (was `commands/`).
  - **Backward compatibility** — old flat layout no longer present in this repo; canopy-runtime continues to support it for skills authored elsewhere.
- **Added `compatibility` field to every skill.**
  - **Form** — free-text per agentskills.io spec.
  - **Content** — declares the canopy-runtime requirement and names the source repo.
  - **Install tools** — listed as alternatives (`gh skill install`, `git clone`, install scripts, plugin marketplace) so the agent picks based on its environment.
- **Added structured safety preamble** at the top of every skill body.
  - **Form** — labeled bullets (not stream-of-consciousness prose).
  - **Detection** — canopy-runtime under `<skills-root>/`, or marker block in the instructions file.
  - **Fail mode** — halts execution on agents without canopy-runtime active.
- **Rewrote `CLAUDE.md` for canopy v0.18.0.**
  - **Plugin install** — no longer requires explicit `/canopy:canopy activate`.
  - **Activation** — canopy-runtime self-activates on first load.
  - **Skill anatomy table** — reflects standard layout.
  - **Op lookup chain** — now lists `references/ops/<name>.md`.
- **Trimmed README install section.**
  - **Removed** — `/canopy:canopy activate` from one-time setup.
  - **Replaced with** — note that activation happens automatically on first agent load.
  - **Skill structure section** — updated to canonical layout.

### Notes

- **`add-changelog-entry` is also published on the `e2e-preview` branch** at `skills/add-changelog-entry/` (canonical publishing location for `gh skill install`).
  - **Purpose** — test fixture for canopy's autonomous-agent E2E tests.
  - **Master branch** — keeps the conventional `.claude/skills/` placement so the examples repo serves as a fully checked-out workspace, not a publishing target.

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

[0.4.0]: https://github.com/kostiantyn-matsebora/claude-canopy-examples/compare/v0.3.0...v0.4.0
[0.3.0]: https://github.com/kostiantyn-matsebora/claude-canopy-examples/compare/v0.2.0...v0.3.0
[0.2.0]: https://github.com/kostiantyn-matsebora/claude-canopy-examples/compare/v0.1.0...v0.2.0
[0.1.0]: https://github.com/kostiantyn-matsebora/claude-canopy-examples/releases/tag/v0.1.0
