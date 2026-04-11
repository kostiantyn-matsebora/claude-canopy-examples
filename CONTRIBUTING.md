# Contributing to claude-canopy-examples

Thanks for contributing.

## Scope

This repo contains example skills and usage patterns for Canopy. Good contributions include:

- new example skills
- improvements to existing examples
- better onboarding and usage docs
- fixes to submodule setup or local wiring

Framework changes should usually go in `claude-canopy`, not here.

## Getting Started

1. Fork the repository.
2. Clone with submodules: `git clone --recurse-submodules ...`
3. Run `.claude/canopy/setup.ps1` or `.claude/canopy/setup.sh`.
4. Create a branch from `master`.
5. Make focused changes.
6. Open a pull request.

## Adding an Example Skill

- Add the skill under `.claude/skills/<skill-name>/`.
- Keep examples practical and easy to copy into a real project.
- Prefer generic prompts and resources over domain-specific internal examples.
- Document how to invoke the skill in `README.md` if it is user-facing.

## Pull Requests

Before opening a pull request, check:

- the examples still work with the current `claude-canopy` submodule
- README setup instructions are still accurate
- the new example demonstrates something distinct and useful

## Commit Messages

Conventional Commits are preferred, for example:

- `feat: add release-note generator example`
- `fix: correct submodule setup instructions`
- `docs: clarify example skill invocations`
