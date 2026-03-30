# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

Portable dotfiles repository for Neovim, Bash (remote Linux servers via SSH/tmux), and Zsh (macOS local).

## Deployment

- `nvim/` symlinks to `~/.config/nvim/`
- `bash/.bashrc` / `bash/.bash_aliases` symlink to `~/`
- `zsh/.zshrc` symlinks to `~/`
- `sync-nvim.sh` — destructive rsync from `nvim/` to `~/.config/nvim/` (prompts for confirmation)

## Architecture

### Neovim

- **Entry**: `nvim/init.lua` → `require("config")` → `lua/config/init.lua`
- **Config load order**: bootstrap lazy.nvim → `globals.lua` → `keymaps.lua` → `options.lua` → `lazy.setup("plugins")`
- **Plugin manager**: lazy.nvim, auto-discovers all files in `lua/plugins/`
- **Completion stack**: blink.cmp (Rust-based, builds from source via cargo) + copilot.lua → blink-cmp-copilot adapter. Copilot's native inline UI is disabled; all suggestions flow through blink.cmp only (score_offset=1000)
- **Clipboard**: OSC 52 for copy (works over SSH). In tmux, paste falls back to register `"`. Outside tmux, full OSC 52 paste.
- **Tree-sitter queries**: Custom aerial.scm for C/C++ in `nvim/after/queries/`

### Shell

- **Bash** (remote Linux): custom PS1 prompt with git branch, vi mode, fzf integration, ARM GCC toolchain paths
- **Zsh** (macOS): oh-my-zsh + powerlevel10k, zsh-syntax-highlighting, vi mode, fzf with fd
- Both shells share: `rm -iv`, `cp -iv`, `mv -iv`, `vi=nvim`, `grx='rg -n'`, fzf with gruvbox-like colors

## Coding Conventions

### Lua (Neovim config)
- **Indentation**: Tabs, not spaces (`tabstop=4`, `shiftwidth=4`)
- **Strings**: Double quotes
- **Trailing commas**: Always include in tables and parameter lists
- **Plugin files**: One plugin per file in `lua/plugins/`, each returns a single lazy.nvim spec table

### Shell
- Bash aliases in `.bash_aliases`, shell config in `.bashrc`
- Zsh aliases inline in `.zshrc`

## Key Design Decisions

- **Remote-first**: All config must work over SSH. No GUI assumptions.
- **tmux-aware**: Clipboard handling differs inside/outside tmux.
- **No expandtab by default**: Uses real tabs. F6 toggles, F7/F8 switch tab size (4/8).
- **Tab-based workflow**: F2/F3 navigate tabs, F9 creates new tab.
- **Black-hole register**: `x`, `c`, `s` use `"_` to prevent clipboard pollution.
- **Leader**: Space
