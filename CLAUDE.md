# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

**arto.vim** is a Vim/Neovim plugin that opens Markdown files in the [Arto](https://github.com/arto-app) application from within the editor. Supports macOS and Linux.

**Requirements:** Vim 9.0+ or Neovim 0.10+, Arto v0.15.0+

## Testing

Tests use [vim-themis](https://github.com/thinca/vim-themis). Clone it first:

```bash
git clone https://github.com/thinca/vim-themis
./vim-themis/bin/themis
```

Run a single spec file:

```bash
./vim-themis/bin/themis test/arto.vimspec
```

## Linting

[vint](https://github.com/Vimjas/vint) is the Vim script linter (runs in CI via reviewdog):

```bash
vint plugin/arto.vim autoload/arto.vim
```

## Architecture

Standard Vim plugin layout with clean separation:

```
plugin/arto.vim   — Entry point: guards, default config (g:arto_path), command definitions
autoload/arto.vim — Lazy-loaded implementation: arto#open(), arto#version()
doc/arto.txt      — Vim help documentation
test/arto.vimspec — vim-themis test suite
```

### Key design points

- **OS detection in `plugin/arto.vim`**: Sets `g:arto_path` default at load time based on `has('mac')` vs Linux.
- **Executable resolution in `s:executable()`** (`autoload/arto.vim`): macOS resolves to `{g:arto_path}/Contents/MacOS/arto` (app bundle); Linux uses `g:arto_path` directly.
- **Process launch**: Uses `jobstart()` (Neovim) or `job_start()` (Vim 9) with detach options so Arto runs independently from the editor.
- **`autoload/` is lazy-loaded**: Only the `plugin/` file is sourced at startup; `autoload/arto.vim` is loaded on first function call.

### Commands defined

| Command | Function called |
|---------|----------------|
| `:Arto [paths]` | `arto#open(...)` |
| `:ArtoVersion` | `arto#version()` |

## CI

Three GitHub Actions workflows in `.github/workflows/`:

- `vim.yml` — Tests on Vim nightly + v9.0.0000 × macOS + Ubuntu
- `neovim.yml` — Tests on Neovim stable + nightly × macOS + Ubuntu
- `reviewdog.yml` — vint linting on PRs
