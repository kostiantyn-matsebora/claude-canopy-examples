# claude-canopy-examples

[![Built with Canopy](https://img.shields.io/badge/built%20with-canopy-2da44e)](https://github.com/kostiantyn-matsebora/claude-canopy)
[![agentskills.io](https://img.shields.io/badge/agentskills.io-compatible-0969da)](https://agentskills.io)
[![Claude Code](https://img.shields.io/badge/Claude%20Code-compatible-D97757?logo=anthropic&logoColor=white)](https://code.claude.com/docs/en/skills)
[![GitHub Copilot](https://img.shields.io/badge/GitHub%20Copilot-compatible-000?logo=githubcopilot&logoColor=white)](https://code.visualstudio.com/docs/copilot/customization/agent-skills)

> Self-contained playground for [Canopy](https://github.com/kostiantyn-matsebora/claude-canopy) — a framework that turns Claude Code and GitHub Copilot skills into executable programs. Clone the repo, open it in either client, and the framework + example skills are ready to use.

## Prerequisites

- [Git](https://git-scm.com/) 2.25+
- An agentskills.io-compatible client — [Claude Code](https://docs.anthropic.com/en/docs/claude-code) or [GitHub Copilot](https://code.visualstudio.com/docs/copilot/overview)

That's all that is required to use the bundled skills. To upgrade Canopy to a newer release, you also need [GitHub CLI 2.91+](https://cli.github.com/) (`gh skill install`).

## Installation

```bash
git clone https://github.com/kostiantyn-matsebora/claude-canopy-examples
cd claude-canopy-examples
```

Open the repo in Claude Code or VS Code with GitHub Copilot — and you're done. The Canopy framework (`canopy-runtime`, `canopy`, `canopy-debug`) is vendored under `.agents/skills/`, the cross-client skills root that both Claude Code and GitHub Copilot read. Both clients pick it up via the marker block committed to `CLAUDE.md` and `.github/copilot-instructions.md`.

The framework skills become available as:

| Slash command | Skill |
| --- | --- |
| `/canopy` | authoring agent |
| `/canopy-debug` | trace wrapper |

`canopy-runtime` is loaded ambiently — it's hidden from the `/` menu by design.

> **Updating Canopy.** The framework is vendored, so upgrading is a `gh skill install --pin vX.Y.Z` followed by a commit:
>
> ```bash
> gh skill install kostiantyn-matsebora/claude-canopy canopy-runtime --dir .agents/skills --pin vX.Y.Z
> gh skill install kostiantyn-matsebora/claude-canopy canopy         --dir .agents/skills --pin vX.Y.Z
> gh skill install kostiantyn-matsebora/claude-canopy canopy-debug   --dir .agents/skills --pin vX.Y.Z
> ```
>
> Then bump `.canopy-version` to match.

## Usage

Open the repository in Claude Code or VS Code/Copilot and invoke any of the example skills by name (or by stating the goal):

| Skill | Invocation example | Tree syntax |
| --- | --- | --- |
| [`generate-readme`](.agents/skills/generate-readme/SKILL.md) | `Generate or update the README for this project` | box-drawing |
| [`add-changelog-entry`](.agents/skills/add-changelog-entry/SKILL.md) | `Add changelog entry for version 1.0.0` | box-drawing |
| [`review-file`](.agents/skills/review-file/SKILL.md) | `Review src/auth.py` | box-drawing |
| [`parallel-review`](.agents/skills/parallel-review/SKILL.md) | `Run a parallel-review on src/auth.py` | box-drawing |
| [`scaffold-skill`](.agents/skills/scaffold-skill/SKILL.md) | `Scaffold a new skill called my-skill` | markdown list (`*`) |
| [`bump-version`](.agents/skills/bump-version/SKILL.md) | `Bump version to 2.1.0` | markdown list (`*`) |

Each skill lives under `.agents/skills/<skill-name>/` and follows the agentskills.io standard layout:

- `SKILL.md` — the skill definition (frontmatter incl. `compatibility` + safety preamble + Tree + Rules + Response)
- `references/ops.md` or `references/ops/<name>.md` — skill-local op definitions
- `references/<other>.md` — supporting docs loaded on demand
- `assets/templates/`, `assets/constants/`, `assets/schemas/`, `assets/policies/`, `assets/checklists/`, `assets/verify/` — static resources
- `scripts/` — executable shell or PowerShell sections

Older skills using the flat layout (category dirs at the skill root: `templates/`, `constants/`, `commands/`, etc.) continue to execute correctly — canopy-runtime resolves `Read` references literally. Run `/canopy improve <skill>` to migrate a legacy-layout skill to the standard layout.

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

See the [Canopy framework documentation](https://github.com/kostiantyn-matsebora/claude-canopy) for the full skill anatomy reference. To author or modify skills with the framework's authoring agent, run `/canopy help` inside Claude Code or Copilot.

## Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feat/my-skill`)
3. Add your skill under `.agents/skills/<skill-name>/`
4. Commit following [Conventional Commits](https://www.conventionalcommits.org/)
5. Open a pull request

See [CONTRIBUTING.md](CONTRIBUTING.md) for repo-specific contribution guidelines.

## License

MIT
