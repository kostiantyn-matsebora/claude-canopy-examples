# add-changelog-entry — Local Ops

---

## COLLECT_COMMITS >> commits

```
COLLECT_COMMITS >> commits
├── Read `commands/commands-git.ps1` for GET_COMMITS_SINCE_TAG section
├── run GET_COMMITS_SINCE_TAG command
├── capture stdout as commits list
└── IF << no commits found
    └── ASK << No commits since last tag. Continue anyway? | Yes | No
```

---

## CLASSIFY_COMMITS << commits >> {added, changed, fixed, removed}

```
CLASSIFY_COMMITS << commits >> {added, changed, fixed, removed}
├── Read `constants/commit-types.md` for prefix-to-category mapping
└── group each commit into Added, Changed, Fixed, or Removed using the mapping
```

---

## PREPEND_ENTRY << version

```
PREPEND_ENTRY << version
├── Read `templates/entry.md`
├── substitute <version>, <date>, <added>, <changed>, <fixed>, <removed>
├── remove any category section (### heading + its content) whose substituted value is empty
└── insert rendered entry immediately after the CHANGELOG.md header block
```
