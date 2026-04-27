-- ============================================================
-- init.lua — Neovim entry point
-- ============================================================

-- Load core options first
require("config.options")
require("config.keymaps")
require("config.autocmds")

-- Bootstrap and load lazy.nvim
require("plugins.core.lazy")
