# parallel-review — Local Ops

---

## EXPLORE_TARGET << target_path >> context

> **Subagent.** Output contract: `assets/schemas/explore-schema.json`. Input contract: `assets/schemas/explore-target-input.json`.
>
> Inputs:
> - `target_path` — file or directory passed as `$ARGUMENTS`

```
EXPLORE_TARGET << target_path
├── Read all files under `target_path`
├── Read `assets/constants/review-config-files.md` for the linting / type-check config files to detect at the project root
└── Emit a context object matching `assets/schemas/explore-schema.json` — `target`, `file_count`, `files` (path + language per entry), `aspects`, detected coding standards
```

---

## REVIEW_ASPECT << aspect | files >> findings

> **Subagent.** Output contract: `assets/schemas/aspect-findings-schema.json`. Input contract: `assets/schemas/review-aspect-input.json`.
>
> Inputs:
> - `aspect` — one of `"security"`, `"performance"`, `"style"`, `"correctness"`
> - `files` — list of `{path, language}` produced by `EXPLORE_TARGET` (the `files` array of `explore-schema.json`)

```
REVIEW_ASPECT << aspect | files
├── Read `assets/constants/review-aspects.md` and select the section matching `aspect`
├── Read each entry in `files` by its `path`
├── Apply the aspect's criteria to the file contents — strict-contract: subagent body uses only `<<` inputs and these static skill assets
├── For each issue, emit one finding shaped to `assets/schemas/aspect-findings-schema.json`:
│   ├── severity (critical / warning / info)
│   ├── file path + line range
│   ├── description
│   └── concrete suggested fix as a code snippet
└── Return the array as `findings`
```

---

## MERGE_ASPECT_FINDINGS << security_findings | perf_findings | style_findings | correctness_findings >> all_findings

> **Input contract:** `assets/schemas/merge-aspect-findings-input.json`
> **Output contract:** `assets/schemas/merge-aspect-findings-output.json`

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

## REPORT_BY_SEVERITY << all_findings

> **Input contract:** `assets/schemas/report-by-severity-input.json`

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
