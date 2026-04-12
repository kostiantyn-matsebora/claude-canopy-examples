# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

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
