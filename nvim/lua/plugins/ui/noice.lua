-- ============================================================
-- plugins/ui/noice.lua — Modern command-line UI
-- ============================================================

return {
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
    opts = {
      -- Route certain messages to mini (bottom-right)
      routes = {
        -- Hide "written" messages
        {
          filter = { event = "msg_show", kind = "", find = "written" },
          opts   = { skip = true },
        },
        -- Hide search count messages
        {
          filter = { event = "msg_show", find = "%d+L, %d+B" },
          opts   = { skip = true },
        },
        -- Show long messages in a popup
        {
          filter = { event = "msg_show", min_height = 10 },
          view   = "popup",
        },
      },
      presets = {
        bottom_search        = true,  -- classic bottom search bar
        command_palette      = true,  -- position cmdline and popupmenu together
        long_message_to_split = true, -- long messages go to a split
        inc_rename           = true,  -- enable incremental renaming
        lsp_doc_border       = true,  -- add border to hover docs
      },
      lsp = {
        override = {
          -- Override vim.lsp.util rendering with noice
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"]                = true,
          ["cmp.entry.get_documentation"]                  = true,
        },
        progress = {
          enabled = false, -- using fidget.nvim instead
        },
        hover = {
          enabled = true,
          silent  = true,
        },
        signature = {
          enabled = true,
        },
      },
      views = {
        cmdline_popup = {
          border = { style = "rounded" },
          position = { row = "40%", col = "50%" },
          size = { width = 60, height = "auto" },
        },
        popupmenu = {
          relative = "editor",
          position = { row = "40%", col = "50%" },
          size = { width = 60, height = 10 },
          border = { style = "rounded" },
        },
      },
    },
    keys = {
      { "<leader>fn", "<cmd>Noice telescope<CR>",    desc = "Noice history (Telescope)" },
      { "<leader>un", function() require("noice").cmd("dismiss") end, desc = "Dismiss notifications" },
      { "<S-Enter>",  function() require("noice").redirect(vim.fn.getcmdline()) end, mode = "c", desc = "Redirect cmdline output" },
    },
  },
}
