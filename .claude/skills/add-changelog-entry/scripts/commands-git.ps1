# Git Commands

# === GET_COMMITS_SINCE_TAG ===

Gets all commit messages since the most recent git tag.
Falls back to all commits if no tag exists.

```powershell
$tag = git describe --tags --abbrev=0 2>$null
if ($tag) {
    git log "$tag..HEAD" --pretty=format:"%s" --no-merges
} else {
    git log --pretty=format:"%s" --no-merges
}
```

**Output:** one commit subject line per stdout line.
