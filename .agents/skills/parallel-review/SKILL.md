---
name: parallel-review
description: Multi-aspect code review using PARALLEL fan-out — runs four independent review subagents concurrently (security / performance / style / correctness), each in its own context window, then merges findings into a unified severity-grouped report. Demonstrates the PARALLEL block primitive (canopy v0.19.0+).
compatibility: Requires the canopy-runtime skill v0.19.0+ (PARALLEL block primitive), published at github.com/kostiantyn-matsebora/claude-canopy. Install with any agentskills.io-compatible tool — e.g. `gh skill install`, `git clone`, the repo's `install.sh`/`install.ps1`, or the Claude Code plugin marketplace. Supports Claude Code and GitHub Copilot.
metadata:
  argument-hint: "<file-or-directory>"
---

> **Runtime required.** This skill uses Canopy tree notation; canopy-runtime must be active.
>
> **Detect canopy-runtime** — present if either:
> - `canopy-runtime/SKILL.md` exists under `.claude/skills/`, `.github/skills/`, or `.agents/skills/`, OR
> - a canopy-runtime marker block exists in `CLAUDE.md` or `.github/copilot-instructions.md`.
>
> **If neither is present** — install canopy-runtime first (see the `compatibility` field for the source and install options), then re-invoke this skill.
>
> Do not interpret the `## Tree` without canopy-runtime active.

Parallel-review target: $ARGUMENTS

---

## Agent

**explore** — read the review target and detect project coding standards. Output contract: `assets/schemas/explore-schema.json`.

Sub-tasks:
- Read all files under `$ARGUMENTS`
- Detect linting / type-check config files at the project root — see `assets/constants/review-config-files.md`

---

## Tree

```
parallel-review
├── EXPLORE >> context
├── SHOW_PLAN >> target | file_count | aspects
├── ASK << Proceed with parallel review? | Yes | No
├── IF << user chose No
│   └── END Cancelled.
├── Read `assets/constants/review-aspects.md` for per-aspect criteria and the `aspect-findings-schema.json` shape each subagent must return
├── PARALLEL
│   ├── Spawn a review subagent for the **security** aspect — apply `assets/constants/review-aspects.md` § Security to `context.target`; output findings into `security_findings` per `assets/schemas/aspect-findings-schema.json`
│   ├── Spawn a review subagent for the **performance** aspect — apply `assets/constants/review-aspects.md` § Performance to `context.target`; output findings into `perf_findings` per `assets/schemas/aspect-findings-schema.json`
│   ├── Spawn a review subagent for the **style** aspect — apply `assets/constants/review-aspects.md` § Style to `context.target`; output findings into `style_findings` per `assets/schemas/aspect-findings-schema.json`
│   └── Spawn a review subagent for the **correctness** aspect — apply `assets/constants/review-aspects.md` § Correctness to `context.target`; output findings into `correctness_findings` per `assets/schemas/aspect-findings-schema.json`
├── MERGE_ASPECT_FINDINGS << security_findings | perf_findings | style_findings | correctness_findings >> all_findings
├── REPORT_BY_SEVERITY << all_findings
└── VERIFY_EXPECTED << assets/verify/verify-expected.md
```

---

## Rules

- Each PARALLEL child runs in its own context window — subagents do not see each other's findings; they only see the shared `context.target` and their assigned aspect's criteria
- Bindings (`>>`) in PARALLEL children are merged in declaration order regardless of completion order — `MERGE_ASPECT_FINDINGS` relies on stable names, not arrival timing
- A single subagent failure does not abort siblings (`Promise.allSettled`) — `MERGE_ASPECT_FINDINGS` handles missing/empty aspects gracefully
- Suggested fixes must be concrete: show the corrected code snippet, not just a description
- Only report what is observable in the provided files — do not speculate

## Response: target | aspects_reviewed | critical | warnings | info | overall_verdict
