# Bump Version Rules

1. Only update files where the version string can be found unambiguously — if a file has multiple version fields, flag it and skip.
2. Do not change any other content in the file beyond the version string.
3. All files must be updated before reporting success — partial updates are an error; roll back if any file fails.
4. The new version must satisfy semver: MAJOR.MINOR.PATCH with optional pre-release suffix (e.g. `1.2.3-rc.1`).
5. For CHANGELOG entries: use ISO 8601 date (YYYY-MM-DD); use Keep a Changelog section headings (Added, Changed, Fixed, Removed).
6. For `go.mod`: only update the module version suffix on a major bump (v2+). For minor/patch bumps, `go.mod` requires no version change — skip it silently.
