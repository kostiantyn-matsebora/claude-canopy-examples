# bump-version — Local Ops

---

## EXPLORE >> context

> **Subagent.** Output contract: `assets/schemas/explore-schema.json`

* EXPLORE >> context
  * Locate version-bearing files at the project root — see `assets/constants/version-file-types.md`
  * Detect whether `CHANGELOG.md` exists at the project root
  * Return a context object matching `assets/schemas/explore-schema.json`

---

## BUMP_FILES << context | new_version

Update the version string in every file from `context.files_to_update`.

* BUMP_FILES << context | new_version
  * IF << package.json present
    * update `"version"` field to new_version
  * IF << pyproject.toml present
    * update `version =` under `[tool.poetry]` or `[project]` to new_version
  * IF << Cargo.toml present
    * update `version =` under `[package]` to new_version
  * IF << go.mod present
    * IF << major version bump (new major > current major)
      * update module version suffix to new_version
    * ELSE
      * skip go.mod
  * IF << version.txt present
    * replace entire file contents with new_version
  * IF << any .csproj files present
    * update `<Version>` and `<AssemblyVersion>` elements to new_version
  * IF << any files with type "other" present
    * Read `templates/other-file-warning.md`
    * report warning for each file substituting its path

---

## BUMP_CHANGELOG << new_version

Prepend a new version entry to CHANGELOG.md using today's date. Idempotent — if an entry for `new_version` already exists (e.g. a prior `add-changelog-entry` run for the same version), this op is a no-op.

* BUMP_CHANGELOG << new_version
  * IF << CHANGELOG.md already contains a `## [new_version]` heading
    * skip (entry for new_version already present — leave existing block untouched)
  * ELSE
    * read recent git commits since last tag >> commits
    * classify commits into Added / Changed / Fixed / Removed buckets
    * prepend formatted entry at top of CHANGELOG.md
