-- ============================================================
-- plugins/tools/rest.lua — HTTP client (Kulala)
-- ============================================================
-- Write .http files and send requests directly from Neovim.
-- Great for testing your FastAPI / PHP / Java REST APIs.
--
-- Usage:
--   Create a file like api-test.http:
--     GET https://api.example.com/users
--     Content-Type: application/json
--
--     ###
--
--     POST https://api.example.com/users
--     Content-Type: application/json
--
--     { "name": "Ruben" }
--
--   Then press <leader>rr to send the request under the cursor.

return {
  {
    "mistweaverco/kulala.nvim",
    ft = { "http", "rest" },
    keys = {
      { "<leader>rr", desc = "REST: run request" },
      { "<leader>ra", desc = "REST: run all" },
      { "<leader>rc", desc = "REST: copy as cURL" },
      { "<leader>ri", desc = "REST: inspect" },
      { "<leader>rs", desc = "REST: show stats" },
    },
    opts = {
      -- Default content-type header
      default_view        = "body",
      default_env_file    = ".env",
      debug               = false,
      winbar              = true,
      venv_filepath       = ".venv/bin/python",
      show_variable_info_text = false,
      icons = {
        inlay = {
          loading = "⏳",
          done    = "✅ ",
          error   = "❌ ",
        },
        lualine = "🐼",
      },
      -- UI split
      split_direction = "vertical",
    },
    config = function(_, opts)
      require("kulala").setup(opts)

      local map = vim.keymap.set
      map("n", "<leader>rr", function() require("kulala").run() end,         { desc = "REST: run request" })
      map("n", "<leader>ra", function() require("kulala").run_all() end,     { desc = "REST: run all" })
      map("n", "<leader>rc", function() require("kulala").copy() end,        { desc = "REST: copy as cURL" })
      map("n", "<leader>ri", function() require("kulala").inspect() end,     { desc = "REST: inspect" })
      map("n", "<leader>rs", function() require("kulala").show_stats() end,  { desc = "REST: show stats" })
      map("n", "]r",         function() require("kulala").jump_next() end,   { desc = "REST: next request" })
      map("n", "[r",         function() require("kulala").jump_prev() end,   { desc = "REST: prev request" })
    end,
  },
}
