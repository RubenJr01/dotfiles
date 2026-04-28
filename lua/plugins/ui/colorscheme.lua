return {
  {
    "navarasu/onedark.nvim",
    lazy = false,
    priority = 999,
    config = function()
      require("onedark").setup({
        style = "deep",
        transparent = false,
        term_colors = true,
        ending_tildes = false,
        cmp_itemkind_reverse = false,
        toggle_style_key = "<leader>ts",
        toggle_style_list = { "deep", "dark", "darker", "cool", "warm", "warmer" },
        code_style = {
          comments  = "italic",
          keywords  = "none",
          functions = "none",
          strings   = "none",
          variables = "none",
        },
        lualine = { transparent = false },
        diagnostics = {
          darker     = true,
          undercurl  = true,
          background = true,
        },
        colors = {},
        highlights = {
          SnacksIndent      = { fg = "#2a3a5c" },
          SnacksIndentScope = { fg = "#4a6fa5" },
        },
      })
      require("onedark").load()
    end,
  },
}