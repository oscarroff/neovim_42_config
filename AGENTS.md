# AGENTS.md

Personal Neovim config for a 42 school student. Based on kickstart.nvim, modularized.

## Structure

```
init.lua              → loads config/ in order: options → keymaps → autocmds → lazy
lua/config/           → vim options, keymaps, autocmds, lazy.nvim bootstrap
lua/plugins/          → one file per plugin domain, auto-imported by lazy.nvim
```

lazy.nvim uses `{ import = "plugins" }` — any `.lua` file in `lua/plugins/` is loaded automatically. No manual registration needed.

## Key conventions

- **Leader key**: `<Space>` (both mapleader and maplocalleader)
- **Tab width**: 4 spaces everywhere (tabstop, softtabstop, shiftwidth)
- **File type**: `.tpp` files registered as `cpp`
- **42 user**: `vim.g.user = "thblack-"`, `vim.g.mail = "thblack-@student.hive.fi"`
- Nerd Font icons enabled (`vim.g.have_nerd_font = true`)

## Plugin loading

Most plugins use lazy loading via `event`, `cmd`, or `keys`. Only `vim-sleuth` and the colorscheme (`tokyonight-night`) load eagerly. When adding a new plugin, prefer lazy-loading triggers.

## 42 school tooling

- `42-header.nvim`: `<F1>` inserts/updates 42 header
- `42-C-Formatter.nvim`: `<leader>cf` formats C files
- `norminette42.nvim`: initially **inactive** (`active = false`). Toggle with `<leader>dn`. Conform.nvim explicitly skips LSP formatting for C/C++ to avoid conflicts with norminette.

## LSP

Four servers configured: `clangd` (C/C++), `lua_ls` (Lua), `ts_ls` (JS/TS), `tailwindcss` (Tailwind classes). `stylua` and `prettier` installed via Mason. Format-on-save is disabled for C/C++ only; JS/TS/CSS/HTML/JSON format with prettier on save.

## Frontend tooling

- **LSP**: `ts_ls` + `tailwindcss` (autocompletion, diagnostics, hover)
- **Formatting**: `prettier` via conform.nvim for js/ts/css/html/json
- **Linting**: `eslint` via nvim-lint (runs on bufenter, bufwritepost, insertleave)
- **Treesitter**: js, ts, tsx, jsx, css, json parsers ensured
- **Tailwind**: `tailwindcss-colors.nvim` colorizes utility classes, `tw-values.nvim` shows values on hover (`<leader>sv`)

## Gotchas

- `lazy-lock.json` is gitignored (contrary to README recommendation)
- `vim-sleuth` auto-detects indent and may override the hardcoded tab=4 for files with different conventions
- `<leader>sa` hardcodes `$HOME/projects` as search path
- No test suite, build scripts, or CI — this is a config repo
- `<C-t>` opens a terminal scoped to Neo-tree's selected directory (complex Neo-tree integration)
- `<leader>z` toggles a reusable bottom terminal split (manages buffer to avoid duplicates)
