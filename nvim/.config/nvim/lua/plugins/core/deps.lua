-- ============================================================
-- plugins/core/deps.lua — Shared dependencies
-- ============================================================

return {
  -- Lua utility library — required by telescope, gitsigns, etc.
  {
    "nvim-lua/plenary.nvim",
    lazy = true,
  },

  -- Nerd Font icons — required by lualine, trouble, neo-tree, etc.
  {
    "nvim-tree/nvim-web-devicons",
    lazy = true,
  },

  -- UI component library — required by noice, neo-tree, etc.
  {
    "MunifTanjim/nui.nvim",
    lazy = true,
  },
}
