# claude-canopy-examples

> Example skills for [Canopy](https://github.com/kostiantyn-matsebora/claude-canopy) — a framework for structuring Claude Code agent skills. Clone this repo, explore the examples, and use them as a starting point for your own skills.

## Prerequisites

- [Git](https://git-scm.com/) 2.20+ (for submodule support)
- [Visual Studio Code](https://code.visualstudio.com/) with the [GitHub Copilot Chat](https://marketplace.visualstudio.com/items?itemName=GitHub.copilot-chat) extension

## Installation

```bash
git clone --recurse-submodules https://github.com/kostiantyn-matsebora/claude-canopy-examples
cd claude-canopy-examples
.\.claude\canopy\setup.ps1
```

> If you cloned without `--recurse-submodules`, run:
>
> ```bash
> git submodule update --init
> .\.claude\canopy\setup.ps1
> ```

## Usage

Open the repository in VS Code and invoke any of the example skills via GitHub Copilot Chat:

| Skill | Invocation example | Tree syntax |
| --- | --- | --- |
| `generate-readme` | `Generate or update the README for this project` | box-drawing |
| `add-changelog-entry` | `Add changelog entry for version 1.0.0` | box-drawing |
| `review-file` | `Review src/auth.py` | box-drawing |
| `scaffold-skill` | `Scaffold a new skill called my-skill` | markdown list (`*`) |
| `bump-version` | `Bump version to 2.1.0` | markdown list (`*`) |

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
