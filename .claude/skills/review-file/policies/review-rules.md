# Code Review Rules

## Severity classification

| Severity | When to apply |
|----------|---------------|
| `critical` | Security vulnerabilities (injection, auth bypass, secrets in code), data loss risk, crashes on valid input, broken API contracts |
| `warning`  | Logic errors, dead code, missing error handling for reachable paths, performance problems in hot paths, API misuse |
| `info`     | Style deviations from project config, redundant imports, naming inconsistencies, missing documentation on public APIs |

## Categories

Use one of: `security`, `correctness`, `performance`, `style`, `maintainability`.

## Scope

- Review only files provided in `$ARGUMENTS`
- Apply the project's own linting rules (from detected config files) as the style baseline
- Do not flag issues that the project's linter/formatter would auto-fix silently

## Suggested fixes

- Always show corrected code, not just a description
- Keep the fix minimal — change only what is needed to address the finding
- If a fix requires context outside the reviewed file, note that explicitly

## Limits

- Flag at most 10 findings per file to keep reviews actionable
- If more than 10 issues exist in one file, report the 10 highest-severity ones and note the count of omitted findings
