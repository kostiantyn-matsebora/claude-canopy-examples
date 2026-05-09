<!-- canopy-runtime-begin -->
## Canopy Runtime

Any `SKILL.md` declaring a `## Tree` section is canopy-flavored. To interpret, load `<skills-root>/canopy-runtime/SKILL.md` (where `<skills-root>` is the first match of `.agents/skills/`, `.claude/skills/`, `.github/skills/`). The runtime SKILL.md handles platform detection, op lookup, and lazy-loads only the spec slices the skill actually uses (per `metadata.canopy-features`).
<!-- canopy-runtime-end -->
