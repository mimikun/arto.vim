# arto.vim

A Vim/Neovim plugin to open Markdown files in [Arto](https://github.com/arto-app), a Markdown reader application. Supports macOS and Linux.

## Requirements

- Vim 9.0+ or Neovim 0.10+
- [Arto](https://github.com/arto-app) v0.15.0+
  - macOS: installed at `/Applications/Arto.app` (configurable via `g:arto_path`)
  - Linux: `arto` command available in `$PATH` (configurable via `g:arto_path`)

## Installation

Use your favorite plugin manager.

For [vim-plug](https://github.com/junegunn/vim-plug):

```vim
Plug 'arto-app/arto.vim'
```

For [lazy.nvim](https://github.com/folke/lazy.nvim):

```lua
{ 'arto-app/arto.vim' }
```

## Usage

### Commands

| Command              | Description                                  |
| -------------------- | -------------------------------------------- |
| `:Arto`              | Open the current file in Arto                |
| `:Arto {path} ...`   | Open the specified file(s) in Arto           |
| `:ArtoVersion`       | Show the version of the Arto executable      |

### Configuration

```vim
" macOS (default: '/Applications/Arto.app')
let g:arto_path = '/Applications/Arto.app'

" Linux (default: 'arto')
let g:arto_path = 'arto'
```

## License

MIT
