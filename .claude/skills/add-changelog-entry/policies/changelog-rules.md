# Changelog Formatting Rules

## Entry structure

- Version heading format: `## [<version>] - YYYY-MM-DD`
- Use today's date (ISO 8601) unless the user specifies otherwise
- Only include category sections that have at least one item — omit empty sections entirely

## Item formatting

- Each item is a single `-` bullet on one line
- Start with a capital letter; no trailing period
- Be specific: "Add retry logic to HTTP client" not "Various fixes"
- Do not repeat the category name in the item text

## Insertion position

- New entries go immediately after the `## [Unreleased]` block (or after the file header if Unreleased is absent)
- Do not move or reformat existing entries

## Version linking (optional)

- If the file already contains `[version]: https://...` reference links at the bottom, append a new reference link for the new version
- Link format: `[<version>]: <repo-url>/compare/v<prev>...v<version>`
