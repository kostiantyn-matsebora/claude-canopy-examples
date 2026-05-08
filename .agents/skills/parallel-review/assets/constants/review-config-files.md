# Lint / Type-Check Config Files

Detect any of these at the project root during EXPLORE; populate `lint_config_detected` / `type_check_config_detected` accordingly. Subagents apply the project's own rules as the style baseline rather than imposing external conventions.

## Lint configs

- `.eslintrc`, `.eslintrc.js`, `.eslintrc.json`, `eslint.config.js`, `eslint.config.mjs`
- `.flake8`, `pyproject.toml` (with `[tool.flake8]` or `[tool.ruff]` sections)
- `.rubocop.yml`
- `.golangci.yml`, `.golangci.toml`
- `clippy.toml`
- `.editorconfig`

## Type-check configs

- `tsconfig.json`, `jsconfig.json`
- `mypy.ini`, `pyrightconfig.json`, `pyproject.toml` (with `[tool.mypy]`)
- `Cargo.toml` (Rust strict mode in `[lints]`)
