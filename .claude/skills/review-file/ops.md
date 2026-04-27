# review-file — Local Ops

---

## REPORT_FINDINGS \<\< severity

```
REPORT_FINDINGS << severity
├── Read `constants/severity-headers.md`
├── filter findings from EXPLORE output where finding.severity == severity
├── sort by file path then line number
├── cap to 10 findings per file
├── IF << more than 10 findings in any file
│   └── report omitted count using `templates/omitted-findings-note.md`
├── IF << header defined for this severity in severity-headers.md
│   └── print header as a blockquote callout before the list
└── FOR_EACH << finding in findings
    ├── print finding using `templates/finding-line.md`
    └── print suggested fix as a fenced code block
```
