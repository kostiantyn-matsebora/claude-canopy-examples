# add-changelog-entry — Local Ops

---

## COLLECT_COMMITS >> commits

```
COLLECT_COMMITS >> commits
├── Read `commands/commands-git.ps1` for GET_COMMITS_SINCE_TAG section
├── run command; capture stdout as commits list
└── IF << no commits found
    └── ASK << No commits since last tag. Continue anyway? | Yes | No
```

---

## CLASSIFY_COMMITS << commits >> {added, changed, fixed, removed}

Group each commit message by conventional-commit prefix:

- `feat:` or `feat(<scope>):` maps to Added
- `fix:` or `fix(<scope>):` maps to Fixed
- `refactor:` / `perf:` / `chore:` maps to Changed
- `revert:` / `remove:` / `delete:` maps to Removed
- unrecognized prefix or plain message maps to Changed

Strip the prefix and scope before recording the message text.

---

## PREPEND_ENTRY << version

```
PREPEND_ENTRY << version
├── Read `templates/entry.md`
├── substitute <version>, <date>, <added>, <changed>, <fixed>, <removed>
└── insert rendered entry immediately after the CHANGELOG.md header block
```
