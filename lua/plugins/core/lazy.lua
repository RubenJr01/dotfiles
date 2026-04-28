-- ============================================================
-- plugins/core/lazy.lua — Plugin manager bootstrap
-- ============================================================

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- Auto-install lazy.nvim if not present
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  -- Load all plugin specs from the plugins directory
  spec = {
    { import = "plugins.core" },
    { import = "plugins.ui" },
    { import = "plugins" },
  },
  defaults = {
    lazy = true, -- every plugin lazy-loads by default
  },
  install = {
    colorscheme = { "onedark", "habamax" },
  },
  checker = {
    enabled = true,   -- auto-check for plugin updates
    notify = false,   -- don't notify on startup
  },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "matchit",
        "matchparen",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
  ui = {
    border = "rounded",
    icons = {
      cmd = " ",
      config = "",
      event = "",
      ft = " ",
      init = " ",
      import = " ",
      keys = " ",
      lazy = "󰒲 ",
      loaded = "●",
      not_loaded = "○",
      plugin = " ",
      runtime = " ",
      source = " ",
      start = "",
      task = "✔ ",
    },
  },
})

-- Keymap to open lazy UI
vim.keymap.set("n", "<leader>L", "<cmd>Lazy<CR>", { desc = "Lazy plugin manager" })
