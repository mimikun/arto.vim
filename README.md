# arto.vim

A Vim/Neovim plugin to open Markdown files in [Arto](https://github.com/arto-app), a native macOS Markdown reader.

## Requirements

- Vim 9.0+ or Neovim 0.10+
- [Arto.app](https://github.com/arto-app) installed at `/Applications/Arto.app` (configurable)

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
" Path to the Arto application bundle (default: '/Applications/Arto.app')
let g:arto_path = '/Applications/Arto.app'
```

## License

MIT
