# Verify Expected — parallel-review

After execution, the following must hold:

- [ ] All four aspect subagents (`security`, `performance`, `style`, `correctness`) were dispatched (each returned a result, even if the result is empty findings)
- [ ] `all_findings` contains entries from every aspect that returned ≥1 finding
- [ ] No finding appears more than once (deduplication ran)
- [ ] Each reported finding includes `file`, `line_start`, `line_end`, `aspect`, `severity`, `description`, and `suggested_fix`
- [ ] Findings are grouped by severity (critical → warning → info)
- [ ] Within each severity group, findings are sorted by file path then line number
- [ ] No more than 10 findings per file per severity were printed (excess noted with omitted count)
- [ ] If all four subagents returned zero findings, the no-findings message was printed
