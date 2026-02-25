# AGENTS.md — my_env Dotfiles

> Portable development environment configuration (Neovim + Bash).
> Designed for remote Linux servers accessed via SSH/tmux.

---

## Repository Structure

```
my_env/
├── AGENTS.md
├── bash/
│   ├── .bashrc          # Shell init, prompt, history, PATH
│   └── .bash_aliases    # Command aliases
└── nvim/
    ├── init.lua          # Entry point → requires lua/config/init.lua
    └── lua/
        ├── config/
        │   ├── init.lua      # Bootstrap lazy.nvim, load config modules
        │   ├── globals.lua   # Leader keys, timeouts, clipboard (OSC 52)
        │   ├── keymaps.lua   # Global key mappings (F-keys, leader combos)
        │   └── options.lua   # Editor options (tabs, search, visual, undo)
        └── plugins/          # One file per plugin (lazy.nvim spec format)
            ├── aerial.lua
            ├── blink.lua
            ├── colorscheme.lua
            ├── copilot.lua
            ├── dashboard.lua
            ├── gitsigns.lua
            ├── indent-blankline.lua
            ├── lsp.lua
            ├── lualine.lua
            ├── markdown.lua
            ├── mini-animate.lua
            ├── mini-indentscope.lua
            ├── neo-tree.lua
            ├── nvim-autopairs.lua
            ├── nvim-treesitter.lua
            ├── overseer.lua
            ├── telescope.lua
            ├── undotree.lua
            └── which-key.lua
```

---

## Architecture Overview

### Plugin Manager
- **lazy.nvim** — bootstrapped in `config/init.lua`
- All plugins auto-discovered from `lua/plugins/` directory
- Each plugin file returns a single lazy.nvim spec table

### Completion Stack
- **blink.cmp** (`saghen/blink.cmp`) — completion engine (Rust-based, built from source)
- **copilot.lua** (`zbirenbaum/copilot.lua`) — AI code suggestion backend
- **blink-cmp-copilot** (`giuxtaposition/blink-cmp-copilot`) — adapter bridging Copilot to blink.cmp
- Copilot's native suggestion UI is disabled; all suggestions flow through blink.cmp's completion menu
- Copilot provider has `score_offset = 1000` for highest priority in completion list

### Clipboard
- OSC 52 for copy (works over SSH)
- In tmux: paste falls back to register `"` (tmux intercepts OSC 52 paste)
- Outside tmux: full OSC 52 paste

### Key Architecture Decisions
- Tab-based workflow (F2/F3 navigate, F9 creates new tab)
- F6/F7/F8 for indentation mode switching (tabs vs spaces, tab size)
- Leader = Space
- System clipboard via `unnamedplus`
- Black-hole register for `x`, `c`, `s` (prevents clipboard pollution)

---

## Coding Conventions

### Lua Style
- **Indentation**: Tabs (not spaces) — `tabstop=4`, `shiftwidth=4`
- **Strings**: Double quotes (`"string"`)
- **Trailing commas**: Always include in tables and parameter lists
- **Comments**: Existing comments may be in Korean or English; new code should use English comments
- **Semicolons**: Do not use (exception: existing code in `blink.lua` has one — leave it)

### Plugin File Pattern
Each file in `lua/plugins/` follows this structure:
```lua
return {
	"author/plugin-name",
	dependencies = { ... },    -- optional
	config = function()        -- or opts = { ... }
		require("plugin").setup({ ... })
	end,
}
```
- One plugin per file
- Filename matches the plugin's primary purpose (e.g., `lsp.lua`, `blink.lua`)
- Dependencies declared inline, not in separate files

### Bash Style
- Standard bash conventions
- Aliases in `.bash_aliases`, everything else in `.bashrc`
- Environment-specific logic guarded with conditionals

---

## Key Patterns & Idioms

### Adding a New Plugin
1. Create `nvim/lua/plugins/<name>.lua`
2. Return a lazy.nvim spec table
3. lazy.nvim auto-discovers it — no manual registration needed

### Modifying Completion Behavior
- Completion sources: edit `sources.default` in `blink.lua`
- Provider config: edit `sources.providers` in `blink.lua`
- Keymaps: edit `keymap` in `blink.lua`
- AI backend: modify `copilot.lua` and its corresponding provider in `blink.lua`

### Modifying Key Mappings
- Global mappings: `config/keymaps.lua`
- Plugin-specific mappings: inside each plugin's config/opts

---

## Important Constraints

1. **Remote-first**: All config must work over SSH. No GUI assumptions.
2. **tmux-aware**: Clipboard handling differs inside/outside tmux.
3. **No expandtab by default**: Uses real tabs. `expandtab` toggled via F6.
4. **blink.cmp builds from source**: Requires Rust toolchain (`cargo`).
5. **Copilot UI disabled**: All AI suggestions go through blink.cmp only — never Copilot's inline ghost text.
6. **Plugin isolation**: Each plugin is self-contained in its own file. Cross-plugin dependencies are declared via `dependencies` field.

---

## Deployment

These dotfiles are deployed by symlinking to appropriate locations:
- `nvim/` → `~/.config/nvim/`
- `bash/.bashrc` → `~/.bashrc`
- `bash/.bash_aliases` → `~/.bash_aliases`
