# Neovim Config Structure

```
~/.config/nvim/
├── init.lua                          ← Entry point
├── lua/
│   ├── config/
│   │   ├── options.lua               ← vim.opt settings
│   │   ├── keymaps.lua               ← Global keybindings
│   │   └── autocmds.lua              ← Autocommands
│   └── plugins/
│       ├── core/
│       │   ├── lazy.lua              ← lazy.nvim bootstrap + setup
│       │   ├── deps.lua              ← plenary, devicons, nui
│       │   └── treesitter.lua        ← nvim-treesitter + textobjects + context
│       ├── lsp/
│       │   ├── lspconfig.lua         ← mason + mason-lspconfig + nvim-lspconfig
│       │   ├── java.lua              ← nvim-jdtls (Java LSP)
│       │   └── formatting.lua        ← conform.nvim + nvim-lint
│       ├── completion/
│       │   └── blink.lua             ← blink.cmp + LuaSnip + friendly-snippets
│       ├── navigation/
│       │   └── harpoon.lua           ← harpoon2
│       ├── git/
│       │   └── gitsigns.lua          ← gitsigns
│       ├── editing/
│       │   └── editing.lua           ← autopairs, autotag, surround, comment, todo-comments
│       ├── ui/
│       │   ├── snacks.lua            ← snacks.nvim (all modules)
│       │   ├── lualine.lua           ← statusline
│       │   ├── colorscheme.lua       ← tokyonight
│       │   ├── which-key.lua         ← keybinding popup
│       │   ├── noice.lua             ← modern cmdline UI
│       │   └── colorizer.lua         ← CSS/hex color preview
│       └── tools/
│           └── rest.lua              ← kulala.nvim (HTTP client)
└── snippets/                         ← Custom VSCode-style snippets
    ├── python.json
    ├── javascript.json
    └── php.json
```

## Snacks replaces these standalone plugins
| Snacks module    | Replaces                  |
|------------------|---------------------------|
| snacks.notifier  | nvim-notify               |
| snacks.indent    | indent-blankline.nvim     |
| snacks.terminal  | toggleterm.nvim           |
| snacks.lazygit   | lazygit.nvim              |
| snacks.dashboard | alpha.nvim / dashboard.nvim |
| snacks.picker    | telescope.nvim (optional) |
| snacks.explorer  | oil.nvim / neo-tree       |
| snacks.input     | dressing.nvim             |
| snacks.scroll    | neoscroll.nvim            |

## Key leader mappings summary
| Key             | Action                        |
|-----------------|-------------------------------|
| `<Space>ff`     | Find files                    |
| `<Space>fg`     | Live grep                     |
| `<Space>fb`     | Buffers                       |
| `<Space>fr`     | Recent files                  |
| `<Space>e`      | File explorer                 |
| `<Space>gg`     | LazyGit                       |
| `<Space>xx`     | Diagnostics (Trouble)         |
| `<Space>ha`     | Harpoon: add file             |
| `<Space>hh`     | Harpoon: menu                 |
| `<Space>z`      | Zen mode                      |
| `<C-\>`         | Toggle terminal               |
| `<Space>rr`     | REST: run HTTP request        |
| `<Space>cf`     | Format buffer                 |
| `<Space>ca`     | Code action                   |
| `gd`            | Go to definition              |
| `K`             | Hover docs                    |
| `<Space>rn`     | Rename symbol                 |
