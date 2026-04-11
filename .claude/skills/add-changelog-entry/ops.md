# add-changelog-entry — Local Ops

---

## COLLECT_COMMITS \>\> commits

```
COLLECT_COMMITS >> commits
├── Read `commands/commands-git.ps1` for GET_COMMITS_SINCE_TAG section
├── run command; capture stdout as commits list
└── IF << no commits found
    └── ASK << No commits since last tag. Continue anyway? | Yes | No
```

---

## CLASSIFY_COMMITS \<\< commits \>\> {added, changed, fixed, removed}

Group each commit message by conventional-commit prefix:

- `feat:` or `feat(<scope>):` → Added
- `fix:` or `fix(<scope>):` → Fixed
- `refactor:` / `perf:` / `chore:` → Changed
- `revert:` / `remove:` / `delete:` → Removed
- unrecognized prefix or plain message → Changed

Strip the prefix and scope before recording the message text.

---

## PREPEND_ENTRY \<\< version

```
PREPEND_ENTRY << version
├── Read `templates/entry.md`
├── substitute <version>, <date>, <added>, <changed>, <fixed>, <removed>
│   — omit any section whose list is empty
└── insert rendered entry immediately after the CHANGELOG.md header block (line 7)
```
