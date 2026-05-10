---
name: parallel-review
description: Multi-aspect code review using PARALLEL fan-out — runs four independent review subagents concurrently (security / performance / style / correctness), each in its own context window, then merges findings into a unified severity-grouped report. Demonstrates the subagent dispatch model (per-op markers + bold call-sites) introduced in canopy v0.20.0.
compatibility: Requires the canopy-runtime skill v0.20.0+ (subagent dispatch model — per-op markers + bold call-sites), published at github.com/kostiantyn-matsebora/claude-canopy. Install with any agentskills.io-compatible tool — e.g. `gh skill install`, `git clone`, the repo's `install.sh`/`install.ps1`, or the Claude Code plugin marketplace. Supports Claude Code and GitHub Copilot.
metadata:
  argument-hint: "<file-or-directory>"
  canopy-features: [interaction, control-flow, parallel, subagent, verify]
  canopy-contracts: strict
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

## Tree

```
parallel-review
├── **EXPLORE_TARGET** << $ARGUMENTS >> context
├── SHOW_PLAN >> target | file_count | aspects
├── ASK << Proceed with parallel review? | Yes | No
├── IF << user chose No
│   └── END Cancelled.
├── Read `assets/constants/review-aspects.md` for per-aspect criteria
├── PARALLEL
│   ├── **REVIEW_ASPECT** << "security"    | context.files >> security_findings
│   ├── **REVIEW_ASPECT** << "performance" | context.files >> perf_findings
│   ├── **REVIEW_ASPECT** << "style"       | context.files >> style_findings
│   └── **REVIEW_ASPECT** << "correctness" | context.files >> correctness_findings
├── MERGE_ASPECT_FINDINGS << security_findings | perf_findings | style_findings | correctness_findings >> all_findings
├── REPORT_BY_SEVERITY << all_findings
└── VERIFY_EXPECTED << assets/verify/verify-expected.md
```

---

## Rules

- Each bold-marked op call (`**EXPLORE_TARGET**`, `**REVIEW_ASPECT**`) dispatches as a subagent — its own context window, no access to parent state outside its `<<` inputs
- PARALLEL children that are bold-marked op calls fan out as parallel subagents in a single agent turn
- Bindings (`>>`) in PARALLEL children are merged in declaration order regardless of completion order — `MERGE_ASPECT_FINDINGS` relies on stable names, not arrival timing
- A single subagent failure does not abort siblings (`Promise.allSettled`) — `MERGE_ASPECT_FINDINGS` handles missing/empty aspects gracefully
- Suggested fixes must be concrete: show the corrected code snippet, not just a description
- Only report what is observable in the provided files — do not speculate

## Response: target | aspects_reviewed | critical | warnings | info | overall_verdict
