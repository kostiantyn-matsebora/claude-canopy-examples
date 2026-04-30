# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.5.0] - 2026-04-30

Sync with Canopy framework `v0.18.0`. All five example skills migrated to the agentskills.io standard layout, with spec-compliant `compatibility` frontmatter and the structured safety preamble.

### Changed

- **All example skills migrated to canonical agentskills.io layout** — only `SKILL.md` at the skill root; `references/ops.md` for ops; `assets/{templates,constants,schemas,policies,verify}/` for static resources; `scripts/` for executable code (was `commands/`). Affects `add-changelog-entry`, `bump-version`, `generate-readme`, `review-file`, `scaffold-skill`. Old flat layout no longer present in this repo, but canopy-runtime continues to support it for skills authored elsewhere.
- **`compatibility` field added to every skill** — free-text per agentskills.io spec, declaring the canopy-runtime requirement and the source repo. Lists install tools (`gh skill install`, `git clone`, install scripts, plugin marketplace) as alternatives so the agent picks based on its environment.
- **Structured safety preamble** at the top of every skill body — labeled bullets covering canopy-runtime detection (under `<skills-root>/`, marker block in instructions file) and what to do if neither is present. Halts execution on agents without canopy-runtime active.
- **CLAUDE.md** rewritten to reflect canopy v0.18.0 — plugin install no longer requires explicit `/canopy:canopy activate`, canopy-runtime self-activates on first load, skill anatomy table reflects standard layout, op lookup chain now includes `references/ops/<name>.md`.
- **README** install section trimmed: `/canopy:canopy activate` removed from one-time setup; activation now happens automatically on first agent load; skill structure section updated to canonical layout.

### Notes

- The `add-changelog-entry` skill is also published on a dedicated `e2e-preview` branch at `skills/add-changelog-entry/` (canonical publishing location for `gh skill install`) — used as a test fixture for canopy's autonomous-agent E2E tests. Master branch keeps the conventional `.claude/skills/` placement so the examples repo serves as a fully checked-out workspace, not a publishing target.

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
