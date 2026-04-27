-- ============================================================
-- plugins/editing/editing.lua
-- ============================================================

return {
  -- Auto-close brackets, quotes, parentheses
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    dependencies = { "saghen/blink.cmp" },
    config = function()
      local autopairs = require("nvim-autopairs")
      autopairs.setup({
        check_ts = true, -- use treesitter for smarter pairing
        ts_config = {
          lua  = { "string" },
          javascript = { "template_string" },
          java = false,
        },
        disable_filetype = { "TelescopePrompt", "vim" },
        fast_wrap = {
          map           = "<M-e>",
          chars         = { "{", "[", "(", '"', "'" },
          pattern       = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
          offset        = 0,
          end_key       = "$",
          keys          = "qwertyuiopzxcvbnmasdfghjkl",
          check_comma   = true,
          highlight     = "Search",
          highlight_grey = "Comment",
        },
      })
    end,
  },

  -- Auto-close and rename HTML/JSX/PHP tags
  {
    "windwp/nvim-ts-autotag",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      opts = {
        enable_close         = true,
        enable_rename        = true,
        enable_close_on_slash = true,
      },
      -- Per-filetype overrides
      per_filetype = {
        ["html"] = { enable_close = false }, -- avoid double-close in html
      },
    },
  },

  -- Surround motions: ys, cs, ds
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    opts = {},
  },

  -- Smart commenting — works in JSX, PHP, HTML mixed files
  {
    "numToStr/Comment.nvim",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      -- Makes Comment.nvim context-aware in JSX/TSX/HTML/PHP
      "JoosepAlviste/nvim-ts-context-commentstring",
    },
    config = function()
      -- Pre-hook for ts-context-commentstring
      require("ts_context_commentstring").setup({
        enable_autocmd = false,
      })

      require("Comment").setup({
        pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
        padding  = true,
        sticky   = true,
        toggler  = { line = "gcc", block = "gbc" },
        opleader = { line = "gc", block = "gb" },
        extra    = { above = "gcO", below = "gco", eol = "gcA" },
        mappings = { basic = true, extra = true },
      })
    end,
  },

  -- Highlight and list TODO / FIXME / NOTE / HACK comments
  {
    "folke/todo-comments.nvim",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { "]t",          function() require("todo-comments").jump_next() end, desc = "Next TODO" },
      { "[t",          function() require("todo-comments").jump_prev() end, desc = "Prev TODO" },
      { "<leader>ft",  "<cmd>TodoPicker<CR>",                               desc = "Find TODOs (picker)" },
      { "<leader>xT",  "<cmd>Trouble todo toggle<CR>",                      desc = "TODOs (Trouble)" },
    },
    opts = {
      signs     = true,
      sign_priority = 8,
      keywords  = {
        FIX  = { icon = " ", color = "error",   alt = { "FIXME", "BUG", "FIXIT", "ISSUE" } },
        TODO = { icon = " ", color = "info" },
        HACK = { icon = " ", color = "warning" },
        WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
        PERF = { icon = "󰅒 ",                   alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
        NOTE = { icon = " ", color = "hint",    alt = { "INFO" } },
        TEST = { icon = "⏲ ", color = "test",   alt = { "TESTING", "PASSED", "FAILED" } },
      },
      highlight = {
        before     = "",
        keyword    = "wide",
        after      = "fg",
        pattern    = [[.*<(KEYWORDS)\s*:]],
        comments_only = true,
      },
      search = {
        command = "rg",
        args = {
          "--color=never", "--no-heading", "--with-filename",
          "--line-number", "--column",
        },
        pattern = [[\b(KEYWORDS):]],
      },
    },
  },
}
