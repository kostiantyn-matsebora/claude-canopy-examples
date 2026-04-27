# bump-version — Local Ops

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

Prepend a new version entry to CHANGELOG.md using today's date.

* BUMP_CHANGELOG << new_version
  * read recent git commits since last tag >> commits
  * classify commits into Added / Changed / Fixed / Removed buckets
  * prepend formatted entry at top of CHANGELOG.md
