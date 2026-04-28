-- ============================================================
-- plugins/navigation/harpoon.lua
-- ============================================================

return {
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { "<leader>ha", desc = "Harpoon: add file" },
      { "<leader>hh", desc = "Harpoon: menu" },
      { "<leader>h1", desc = "Harpoon: file 1" },
      { "<leader>h2", desc = "Harpoon: file 2" },
      { "<leader>h3", desc = "Harpoon: file 3" },
      { "<leader>h4", desc = "Harpoon: file 4" },
      { "<leader>h5", desc = "Harpoon: file 5" },
      { "[H",         desc = "Harpoon: prev" },
      { "]H",         desc = "Harpoon: next" },
    },
    config = function()
      local harpoon = require("harpoon")
      harpoon:setup({
        settings = {
          save_on_toggle = true,
          sync_on_ui_close = true,
        },
      })

      local map = vim.keymap.set

      map("n", "<leader>ha", function() harpoon:list():add() end,             { desc = "Harpoon: add file" })
      map("n", "<leader>hh", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "Harpoon: menu" })

      map("n", "<leader>h1", function() harpoon:list():select(1) end, { desc = "Harpoon: file 1" })
      map("n", "<leader>h2", function() harpoon:list():select(2) end, { desc = "Harpoon: file 2" })
      map("n", "<leader>h3", function() harpoon:list():select(3) end, { desc = "Harpoon: file 3" })
      map("n", "<leader>h4", function() harpoon:list():select(4) end, { desc = "Harpoon: file 4" })
      map("n", "<leader>h5", function() harpoon:list():select(5) end, { desc = "Harpoon: file 5" })

      map("n", "]H", function() harpoon:list():next() end, { desc = "Harpoon: next" })
      map("n", "[H", function() harpoon:list():prev() end, { desc = "Harpoon: prev" })
    end,
  },
}
