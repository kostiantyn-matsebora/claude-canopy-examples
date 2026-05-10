# review-file — Local Ops

---

## EXPLORE >> context

> **Subagent.** Output contract: `assets/schemas/explore-schema.json`

* EXPLORE >> context
  * Read all files under `$ARGUMENTS`
  * Detect linting and type-check config files at the project root — see `assets/constants/review-config-files.md`
  * Apply review criteria; emit findings + detected coding standards as a context object matching `assets/schemas/explore-schema.json`

---

## REPORT_FINDINGS \<\< severity

```
REPORT_FINDINGS << severity
├── Read `assets/constants/severity-headers.md`
├── filter findings from EXPLORE output where finding.severity == severity
├── sort by file path then line number
├── cap to 10 findings per file
├── IF << more than 10 findings in any file
│   └── report omitted count using `assets/templates/omitted-findings-note.md`
├── IF << header defined for this severity in assets/constants/severity-headers.md
│   └── print header as a blockquote callout before the list
└── FOR_EACH << finding in findings
    ├── print finding using `assets/templates/finding-line.md`
    └── print suggested fix as a fenced code block
```
