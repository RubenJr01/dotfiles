-- ============================================================
-- plugins/completion/blink.lua — blink.cmp + LuaSnip
-- ============================================================

return {
  -- Snippet engine
  {
    "L3MON4D3/LuaSnip",
    lazy = true,
    build = (function()
      -- Build jsregexp for snippet transformations (optional)
      if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
        return
      end
      return "make install_jsregexp"
    end)(),
    dependencies = {
      -- Pre-made snippet collection for all your languages
      "rafamadriz/friendly-snippets",
    },
    config = function()
      local luasnip = require("luasnip")

      -- Load VSCode-style snippets from friendly-snippets
      require("luasnip.loaders.from_vscode").lazy_load()

      -- Load any custom snippets from ~/.config/nvim/snippets/
      require("luasnip.loaders.from_vscode").lazy_load({
        paths = { vim.fn.stdpath("config") .. "/snippets" },
      })

      luasnip.config.setup({
        history = true,
        update_events = { "TextChanged", "TextChangedI" },
        enable_autosnippets = true,
      })

      -- Jump forward/backward through snippet placeholders
      vim.keymap.set({ "i", "s" }, "<C-l>", function()
        if luasnip.expand_or_jumpable() then luasnip.expand_or_jump() end
      end, { desc = "Snippet: expand or jump forward" })

      vim.keymap.set({ "i", "s" }, "<C-h>", function()
        if luasnip.jumpable(-1) then luasnip.jump(-1) end
      end, { desc = "Snippet: jump back" })
    end,
  },

  -- Completion engine
  {
    "saghen/blink.cmp",
    event = { "InsertEnter", "CmdlineEnter" },
    -- Use pre-built binaries (no Rust toolchain needed)
    version = "1.*",
    dependencies = {
      "L3MON4D3/LuaSnip",
      "rafamadriz/friendly-snippets",
    },
    opts = {
      -- Use LuaSnip as the snippet provider
      snippets = {
        preset = "luasnip",
      },

      -- Completion sources
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
        -- Per-filetype overrides
        per_filetype = {
          sql = { "snippets", "buffer" },
          -- Add dadbod if you use vim-dadbod for DB queries:
          -- sql = { "dadbod", "snippets", "buffer" },
        },
      },

      -- Keymaps
      keymap = {
        preset = "default",
        -- Accept with Enter
        ["<CR>"]  = { "accept", "fallback" },
        -- Navigate menu with Tab/S-Tab
        ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
        ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
        -- Scroll docs
        ["<C-b>"] = { "scroll_documentation_up", "fallback" },
        ["<C-f>"] = { "scroll_documentation_down", "fallback" },
        -- Show/hide
        ["<C-Space>"] = { "show", "show_documentation", "hide_documentation" },
        ["<C-e>"]     = { "hide", "fallback" },
      },

      -- Appearance
      appearance = {
        nerd_font_variant = "mono",
        kind_icons = {
          Text          = "󰉿",
          Method        = "󰆧",
          Function      = "󰊕",
          Constructor   = "",
          Field         = "󰜢",
          Variable      = "󰀫",
          Class         = "󰠱",
          Interface     = "",
          Module        = "",
          Property      = "󰜢",
          Unit          = "󰑭",
          Value         = "󰎠",
          Enum          = "",
          Keyword       = "󰌋",
          Snippet       = "",
          Color         = "󰏘",
          File          = "󰈙",
          Reference     = "󰈇",
          Folder        = "󰉋",
          EnumMember    = "",
          Constant      = "󰏿",
          Struct        = "󰙅",
          Event         = "",
          Operator      = "󰆕",
          TypeParameter = "",
        },
      },

      -- Completion menu behavior
      completion = {
        accept = {
          auto_brackets = { enabled = true },
        },
        menu = {
          border = "rounded",
          draw = {
            treesitter = { "lsp" },
            columns = {
              { "label", "label_description", gap = 1 },
              { "kind_icon", "kind", gap = 1 },
            },
          },
        },
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 200,
          window = {
            border = "rounded",
          },
        },
        ghost_text = {
          enabled = true,
        },
      },

      -- Fuzzy matching
      fuzzy = {
        implementation = "prefer_rust_with_warning",
      },
    },
  },
}
