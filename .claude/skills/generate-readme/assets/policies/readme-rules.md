# README Generation Rules

## Content

- The first paragraph must describe what the project does and who it is for
- Prerequisites lists only hard requirements (runtime version, system tools); skip optional dev tools
- Installation section must contain a copy-pasteable command sequence that works from a clean clone
- Usage section must contain at least one concrete example command or code snippet
- Do not include badge placeholders unless a CI/CD config file is detected in the repo

## Structure

- Use H2 (`##`) for top-level sections; H3 (`###`) for subsections only
- Section order: title + tagline → Prerequisites → Installation → Usage → Configuration (if detected) → Contributing → License
- Omit sections that have no content to fill — do not emit empty headings

## Preservation

- Any section heading not present in `templates/readme.md` is considered a custom section
- Custom sections must be re-inserted at their original line position after merge
- Never rewrite prose inside a custom section — only touch standard sections

## Tone

- Use imperative voice in commands and instructions ("Run", "Clone", "Set")
- Keep sentences short; avoid marketing language
