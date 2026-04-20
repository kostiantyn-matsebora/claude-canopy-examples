# Commit Type Mapping

| Prefix pattern | Category |
|---|---|
| `feat:` / `feat(<scope>):` | Added |
| `fix:` / `fix(<scope>):` | Fixed |
| `refactor:` / `perf:` / `chore:` | Changed |
| `revert:` / `remove:` / `delete:` | Removed |
| unrecognized prefix or plain message | Changed |

Strip the prefix and scope before recording the message text.
