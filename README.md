# claude-canopy-examples

[![Built with Canopy](https://img.shields.io/badge/built%20with-canopy-2da44e)](https://github.com/kostiantyn-matsebora/claude-canopy)
[![agentskills.io](https://img.shields.io/badge/agentskills.io-compatible-0969da)](https://agentskills.io)
[![Claude Code](https://img.shields.io/badge/Claude%20Code-compatible-D97757?logo=anthropic&logoColor=white)](https://code.claude.com/docs/en/skills)
[![GitHub Copilot](https://img.shields.io/badge/GitHub%20Copilot-compatible-000?logo=githubcopilot&logoColor=white)](https://code.visualstudio.com/docs/copilot/customization/agent-skills)

> Example skills for [Canopy](https://github.com/kostiantyn-matsebora/claude-canopy) — a framework for structuring Claude Code agent skills. Clone this repo, explore the examples, and use them as a starting point for your own skills.

## Prerequisites

- [Git](https://git-scm.com/) 2.25+
- [Claude Code](https://docs.anthropic.com/en/docs/claude-code) (`claude` in your terminal) — required to install the Canopy plugin

## Installation

Clone the repo and install the Canopy framework as a Claude Code plugin (one time, user-scoped):

```bash
git clone https://github.com/kostiantyn-matsebora/claude-canopy-examples
cd claude-canopy-examples
```

Then inside Claude Code (or run `claude` to start a session), execute:

```
/plugin marketplace add kostiantyn-matsebora/claude-canopy
/plugin install canopy@claude-canopy
```

- These two commands install all three framework skills (`canopy-runtime`, `canopy`, `canopy-debug`) at user scope — run them once per machine.
- Since canopy v0.18.0, **canopy-runtime self-activates on first load** — the runtime writes the marker block to this project's `CLAUDE.md` (or `.github/copilot-instructions.md` on Copilot) automatically when an agent first loads `canopy-runtime/SKILL.md`. No separate `/canopy:canopy activate` step is required.
- The legacy `/canopy:canopy activate` op is still available — use it to force a re-write after a release that changed the marker block content.

> **Updating Canopy:** `/plugin update canopy@claude-canopy` from any Claude Code session. The next agent invocation re-applies activation idempotently.

## Usage

Open the repository in Claude Code and invoke any of the example skills by name (or by stating the goal):

| Skill | Invocation example | Tree syntax |
| --- | --- | --- |
| [`generate-readme`](.claude/skills/generate-readme/SKILL.md) | `Generate or update the README for this project` | box-drawing |
| [`add-changelog-entry`](.claude/skills/add-changelog-entry/SKILL.md) | `Add changelog entry for version 1.0.0` | box-drawing |
| [`review-file`](.claude/skills/review-file/SKILL.md) | `Review src/auth.py` | box-drawing |
| [`scaffold-skill`](.claude/skills/scaffold-skill/SKILL.md) | `Scaffold a new skill called my-skill` | markdown list (`*`) |
| [`bump-version`](.claude/skills/bump-version/SKILL.md) | `Bump version to 2.1.0` | markdown list (`*`) |

Each skill lives under `.claude/skills/<skill-name>/` and follows the agentskills.io standard layout (canopy v0.18.0+):

- `SKILL.md` — the skill definition (frontmatter incl. `compatibility` + safety preamble + Tree + Rules + Response)
- `references/ops.md` or `references/ops/<name>.md` — skill-local op definitions
- `references/<other>.md` — supporting docs loaded on demand
- `assets/templates/`, `assets/constants/`, `assets/schemas/`, `assets/policies/`, `assets/checklists/`, `assets/verify/` — static resources
- `scripts/` — executable shell or PowerShell sections

Older skills using the flat layout (category dirs at the skill root: `templates/`, `constants/`, `commands/`, etc.) continue to execute correctly — canopy-runtime resolves `Read` references literally. Run `/canopy:canopy improve <skill>` to migrate a legacy-layout skill to the standard layout.

### Tree syntax

Canopy supports two equivalent ways to write a skill tree. Both are shown in these examples:

**Markdown list syntax** — `*` nested lists written directly under `## Tree` (no fenced code block):

```markdown
## Tree

* skill-name
  * SHOW_PLAN >> field1 | field2
  * ASK << Proceed? | Yes | No
  * IF << condition
    * branch action
  * ELSE
    * other action
```

**Box-drawing syntax** — fenced code block with tree characters:

```markdown
## Tree

\`\`\`
skill-name
├── SHOW_PLAN >> field1 | field2
├── ASK << Proceed? | Yes | No
├── IF << condition
│   └── branch action
└── ELSE
    └── other action
\`\`\`
```

See the [Canopy framework documentation](https://github.com/kostiantyn-matsebora/claude-canopy) for the full skill anatomy reference. To author or modify skills with the framework's authoring agent, run `/canopy:canopy help` inside Claude Code (the plugin namespace prefix `canopy:` resolves the plugin's bundled commands).

## Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feat/my-skill`)
3. Add your skill under `.claude/skills/<skill-name>/`
4. Commit following [Conventional Commits](https://www.conventionalcommits.org/)
5. Open a pull request

See [CONTRIBUTING.md](CONTRIBUTING.md) for repo-specific contribution guidelines.

## License

MIT
