# parallel-review — Local Ops

---

## MERGE_ASPECT_FINDINGS \<\< security_findings | perf_findings | style_findings | correctness_findings \>\> all_findings

```
MERGE_ASPECT_FINDINGS << security_findings | perf_findings | style_findings | correctness_findings
├── Read `assets/schemas/aspect-findings-schema.json` for the per-aspect shape
├── FOR_EACH << aspect_findings in [security_findings, perf_findings, style_findings, correctness_findings]
│   ├── IF << aspect_findings is missing or empty
│   │   └── continue (the subagent failed or found nothing — do not error out)
│   └── append all entries to `all_findings`, tagging each with its source aspect
├── deduplicate findings that match on (file, line_start, line_end, description)
└── return `all_findings` shaped to combine all entries
```

---

## REPORT_BY_SEVERITY \<\< all_findings

```
REPORT_BY_SEVERITY << all_findings
├── Read `assets/constants/severity-headers.md`
├── group findings by severity (critical / warning / info)
├── within each severity, sort by file path then line number
├── cap to 10 findings per file per severity
├── IF << any findings at `critical` severity
│   ├── print critical header from `assets/constants/severity-headers.md`
│   └── FOR_EACH << finding in critical findings
│       ├── print finding using `assets/templates/finding-line.md`
│       └── print suggested fix as a fenced code block
├── IF << any findings at `warning` severity
│   ├── print warning header
│   └── FOR_EACH << finding in warning findings
│       └── print finding + suggested fix
├── IF << any findings at `info` severity
│   ├── print info header
│   └── FOR_EACH << finding in info findings
│       └── print finding + suggested fix
└── IF << no findings at any severity
    └── report from `assets/constants/no-findings-message.md`
```
