-- ============================================================
-- plugins/ui/which-key.lua
-- ============================================================

return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      preset = "modern",
      delay = 400,
      icons = {
        breadcrumb = "»",
        separator = "➜",
        group = "+",
        ellipsis = "…",
        rules = false,
        colors = true,
      },
      win = {
        border = "rounded",
        padding = { 1, 2 },
      },
    },
    config = function(_, opts)
      local wk = require("which-key")
      wk.setup(opts)

      -- Register group names so they show nicely in the popup
      wk.add({
        { "<leader>b",  group = "buffer" },
        { "<leader>c",  group = "code / LSP" },
        { "<leader>f",  group = "find / picker" },
        { "<leader>g",  group = "git" },
        { "<leader>j",  group = "java" },
        { "<leader>r",  group = "rename / run" },
        { "<leader>s",  group = "swap / surround" },
        { "<leader>t",  group = "terminal" },
        { "<leader>u",  group = "ui toggles" },
        { "<leader>x",  group = "diagnostics / trouble" },
        { "<leader>z",  group = "zen" },
      })
    end,
  },
}
