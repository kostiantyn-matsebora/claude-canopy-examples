# review-file — Local Ops

---

## REPORT_FINDINGS \<\< severity [| header_message]

```
REPORT_FINDINGS << severity
├── filter findings from EXPLORE output where finding.severity == severity
├── sort by file path then line number
├── IF << header_message provided
│   └── print header_message as a blockquote callout before the list
└── for each finding
    ├── print "**<file>:<line>** — <description>"
    └── print suggested fix as a fenced code block
```
