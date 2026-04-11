# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.1.0] - 2026-04-12

### Added

- Add claude-canopy as a git submodule at `.claude/canopy` with setup scripts for Windows (ps1) and Linux/macOS (sh)
- Add `generate-readme` example skill — analyzes project structure and generates or updates README.md
- Add `add-changelog-entry` example skill — reads git commits since last tag and prepends a Keep a Changelog entry
- Add `review-file` example skill — performs structured code review grouped by severity with suggested fixes
- Add README.md with project overview, prerequisites, installation, usage, and contributing sections
- Fix skill discovery for bundled canopy skills by creating directory junctions/symlinks in `.claude/skills/`

## [Unreleased]

[0.1.0]: https://github.com/kostiantyn-matsebora/claude-canopy-examples/releases/tag/v0.1.0
