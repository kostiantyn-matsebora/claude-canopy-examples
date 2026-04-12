---
name: bump-version
description: Bump the project version across all version-bearing files (package.json, pyproject.toml, Cargo.toml, go.mod, etc.) and prepend a CHANGELOG entry. Uses the markdown list tree syntax.
argument-hint: "<new-version>  (e.g. 2.1.0)"
---

New version: $ARGUMENTS

---

## Agent

**explore** — reads the project root for version-bearing files (package.json, pyproject.toml, Cargo.toml, go.mod, version.txt, any .csproj files) and the current CHANGELOG.md if present. Returns current version, list of files to update, and whether a CHANGELOG exists.

---

## Tree

* bump-version
  * EXPLORE >> context
  * validate $ARGUMENTS is a valid semver string; END if not
  * IF << new version is not greater than current version
    * END New version must be greater than current version (<current_version>)
  * SHOW_PLAN >> current version | new version | files to update | changelog action
  * ASK << Proceed? | Yes | No
  * BUMP_FILES << context | $ARGUMENTS
  * IF << CHANGELOG.md exists
    * BUMP_CHANGELOG << $ARGUMENTS
  * ELSE
    * skip changelog — file not present
  * VERIFY_EXPECTED << verify/verify-expected.md

## Rules

- Read `policies/bump-rules.md` before modifying any file
- Never modify a file if the version string cannot be found unambiguously
- All version strings must be updated atomically — partial updates are an error

## Response: new version | files updated | changelog updated
