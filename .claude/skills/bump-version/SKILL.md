---
name: bump-version
description: Bump the project version across all version-bearing files (package.json, pyproject.toml, Cargo.toml, go.mod, etc.) and prepend a CHANGELOG entry. Uses the markdown list tree syntax.
argument-hint: "<new-version>  (e.g. 2.1.0)"
---

New version: $ARGUMENTS

---

## Agent

**explore** — reads the project root for version-bearing files (package.json, pyproject.toml, Cargo.toml, go.mod, version.txt, any .csproj files) and the current CHANGELOG.md if present.

---

## Tree

* bump-version
  * EXPLORE >> context
  * IF << $ARGUMENTS is not a valid semver string
    * END Version argument is not valid semver — expected MAJOR.MINOR.PATCH
  * IF << new version is not greater than current version
    * END New version must be greater than current version (context.current_version)
  * bind new_version = $ARGUMENTS
  * SHOW_PLAN >> current version | new version | files to update | changelog action
  * ASK << Proceed? | Yes | No
  * Read `policies/bump-rules.md` for version update constraints
  * BUMP_FILES << context | new_version
  * IF << CHANGELOG.md exists
    * BUMP_CHANGELOG << new_version
  * ELSE
    * skip changelog — file not present
  * VERIFY_EXPECTED << verify/verify-expected.md

## Rules

- Never modify a file if the version string cannot be found unambiguously
- All version strings must be updated atomically — partial updates are an error

## Response: new version | files updated | changelog updated
