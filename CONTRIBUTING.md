# Contributing to claude-canopy-examples

Thanks for contributing.

## Scope

This repo contains example skills and usage patterns for Canopy. Good contributions include:

- new example skills
- improvements to existing examples
- better onboarding and usage docs
- migrations to align with the latest Canopy framework conventions

Framework changes should usually go in `claude-canopy`, not here.

## Getting Started

1. Fork the repository.
2. Clone: `git clone https://github.com/<your-fork>/claude-canopy-examples`
3. Inside Claude Code, install the Canopy plugin once per machine:

   ```
   /plugin marketplace add kostiantyn-matsebora/claude-canopy
   /plugin install canopy@claude-canopy
   ```

   canopy-runtime self-activates on first agent load (canopy v0.18.0+).
4. Create a branch from `master`.
5. Make focused changes.
6. Open a pull request.

## Adding an Example Skill

- Add the skill under `.claude/skills/<skill-name>/` following the agentskills.io standard layout — only `SKILL.md` at the skill root, with `references/ops.md` for ops, `assets/{templates,constants,schemas,policies,verify}/` for static resources, and `scripts/` for executable code.
- Frontmatter must include `compatibility` (free-text, max 500 chars per agentskills.io spec) declaring the canopy-runtime requirement and source repo. Or just run `/canopy:canopy scaffold <skill-name>` — it generates the canonical structure.
- Open the body with the structured safety preamble before `$ARGUMENTS` (also auto-inserted by `/canopy:canopy scaffold`).
- Keep examples practical and easy to copy into a real project.
- Prefer generic prompts and resources over domain-specific internal examples.
- Document how to invoke the skill in `README.md` if it is user-facing.

## Pull Requests

Before opening a pull request, check:

- the examples still execute correctly under the current Canopy plugin (`/plugin update canopy@claude-canopy` to refresh)
- README setup instructions are still accurate
- the new example demonstrates something distinct and useful
- frontmatter passes `/canopy:canopy validate <skill-name>` (no Errors)

## Commit Messages

Conventional Commits are preferred, for example:

- `feat: add release-note generator example`
- `fix: correct submodule setup instructions`
- `docs: clarify example skill invocations`
