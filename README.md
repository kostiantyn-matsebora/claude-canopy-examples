# claude-canopy-examples

> Example skills for [Canopy](https://github.com/kostiantyn-matsebora/claude-canopy) — a framework for structuring Claude Code agent skills. Clone this repo, explore the examples, and use them as a starting point for your own skills.

## Prerequisites

- [Git](https://git-scm.com/) 2.25+
- Any Claude Code-compatible AI coding assistant — for example:
  - [Claude Code CLI](https://docs.anthropic.com/en/docs/claude-code) (`claude` in your terminal)
  - [VS Code](https://code.visualstudio.com/) with [GitHub Copilot Chat](https://marketplace.visualstudio.com/items?itemName=GitHub.copilot-chat) or the [Claude extension](https://marketplace.visualstudio.com/items?itemName=Anthropic.claude-code)
  - Any editor or CLI that supports the `.claude/` skill and agent conventions

## Installation

```bash
git clone https://github.com/kostiantyn-matsebora/claude-canopy-examples
cd claude-canopy-examples
pwsh .claude\canopy\setup.ps1    # Windows
bash .claude/canopy/setup.sh     # Linux / macOS
```

The setup script creates junctions/symlinks so Claude Code can discover the bundled Canopy skills and agents. Re-run it after each `git pull` that updates `.claude/canopy/`.

> **Updating Canopy:** pull the latest framework into this repo's history:
>
> ```bash
> git subtree pull --prefix=.claude/canopy https://github.com/kostiantyn-matsebora/claude-canopy master --squash
> ```

## Usage

Open the repository in your AI coding assistant and invoke any of the example skills:

| Skill | Invocation example | Tree syntax |
| --- | --- | --- |
| [`generate-readme`](.claude/skills/generate-readme/skill.md) | `Generate or update the README for this project` | box-drawing |
| [`add-changelog-entry`](.claude/skills/add-changelog-entry/skill.md) | `Add changelog entry for version 1.0.0` | box-drawing |
| [`review-file`](.claude/skills/review-file/skill.md) | `Review src/auth.py` | box-drawing |
| [`scaffold-skill`](.claude/skills/scaffold-skill/skill.md) | `Scaffold a new skill called my-skill` | markdown list (`*`) |
| [`bump-version`](.claude/skills/bump-version/skill.md) | `Bump version to 2.1.0` | markdown list (`*`) |

Each skill lives under `.claude/skills/<skill-name>/` and contains:

- `skill.md` — the skill definition (frontmatter + Tree + Rules)
- `ops.md` — skill-local op definitions
- `schemas/`, `templates/`, `policies/`, `commands/`, `verify/` — supporting resources

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

See the [Canopy framework documentation](https://github.com/kostiantyn-matsebora/claude-canopy) for the full skill anatomy reference.

## Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feat/my-skill`)
3. Add your skill under `.claude/skills/<skill-name>/`
4. Commit following [Conventional Commits](https://www.conventionalcommits.org/)
5. Open a pull request

See [CONTRIBUTING.md](CONTRIBUTING.md) for repo-specific contribution guidelines.

## License

MIT
