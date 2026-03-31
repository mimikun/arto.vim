# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

**arto.nvim** is a Neovim plugin that opens Markdown files in the [Arto](https://github.com/arto-app) application from within the editor. Supports macOS and Linux.

**Requirements:** Neovim 0.10+, Arto v0.15.0+

## Testing

Tests use [plenary.nvim](https://github.com/nvim-lua/plenary.nvim). Clone it alongside the repo first:

```bash
git clone https://github.com/nvim-lua/plenary.nvim
```

Run tests:

```bash
nvim --headless -u tests/minimal_init.lua -c "PlenaryBustedDirectory test/ {sequential=true}" -c "qa!"
```

Run a single spec file:

```bash
nvim --headless -u tests/minimal_init.lua -c "PlenaryBustedFile test/arto_spec.lua" -c "qa!"
```

## Linting

[stylua](https://github.com/JohnnyMorganz/StyLua) is the Lua formatter (runs in CI via reviewdog):

```bash
stylua --check lua/ plugin/ test/ tests/
```

## Architecture

Neovim Lua plugin layout:

```
plugin/arto.lua   — Entry point: guards, default config (g:arto_path), command definitions
lua/arto/init.lua — Implementation: arto.open(), arto.version()
doc/arto.txt      — Vim help documentation
test/arto_spec.lua — plenary.nvim test suite
tests/minimal_init.lua — Test bootstrap config
```

### Key design points

- **OS detection in `plugin/arto.lua`**: Sets `g:arto_path` default at load time based on `vim.fn.has('mac')` vs Linux.
- **Executable resolution in `executable()`** (`lua/arto/init.lua`): macOS resolves to `{g:arto_path}/Contents/MacOS/arto` (app bundle); Linux uses `g:arto_path` directly.
- **Process launch**: Uses `vim.fn.jobstart()` with detach options so Arto runs independently from the editor.
- **`lua/` is lazy-loaded**: Only the `plugin/` file is sourced at startup; `lua/arto/init.lua` is loaded on first `require('arto')` call.

### Commands defined

| Command | Function called |
|---------|----------------|
| `:Arto [paths]` | `require('arto').open(...)` |
| `:ArtoVersion` | `require('arto').version()` |

## CI

Two GitHub Actions workflows in `.github/workflows/`:

- `neovim.yml` — Tests on Neovim stable + nightly × macOS + Ubuntu
- `reviewdog.yml` — stylua linting on PRs
