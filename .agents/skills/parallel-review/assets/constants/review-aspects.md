# Review Aspects — Per-Subagent Criteria

Each subagent under the `PARALLEL` block in `SKILL.md` reviews the target through one of these lenses. Each subagent emits a `aspect-findings-schema.json`-shaped result; the parent merges them.

---

## Security

Look for:
- Injection vectors (SQL, command, XSS, prototype pollution)
- Authentication / authorization bypasses
- Hardcoded secrets, API keys, credentials, tokens
- Insecure deserialization, unsafe `eval`, dangerous regexes
- Missing or inconsistent input validation at trust boundaries
- Unsafe filesystem / network operations (path traversal, SSRF)

Severity guide:
- `critical` — exploitable as written
- `warning` — defense-in-depth gap or weak primitive
- `info` — hardening recommendation

---

## Performance

Look for:
- Obvious algorithmic issues (nested loops over large inputs, repeated allocations)
- Synchronous I/O in hot paths
- Missing memoization / caching of pure expensive computations
- N+1 query patterns
- Excessive logging or string formatting in tight loops

Severity guide:
- `critical` — quadratic or worse complexity in production paths
- `warning` — measurable but bounded slowdown
- `info` — micro-optimization

---

## Style

Look for:
- Inconsistencies with the project's own linting / formatting config (detected during EXPLORE)
- Naming that contradicts surrounding conventions
- Dead code, redundant imports
- Comments that paraphrase obvious code

Severity guide:
- `warning` — divergence from the project's own enforced rules
- `info` — divergence from common conventions but not project-specific

Do not flag issues that the project's linter / formatter would auto-fix silently.

---

## Correctness

Look for:
- Logic errors, off-by-one, wrong operator
- Unhandled error paths reachable from valid input
- Race conditions in concurrent code
- API misuse (wrong arguments, ignored return values, missing await)
- Type mismatches the type checker would flag

Severity guide:
- `critical` — visible failure on a normal input
- `warning` — failure under specific reachable conditions
- `info` — robustness improvement
