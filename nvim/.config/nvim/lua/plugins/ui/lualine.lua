-- ============================================================
-- plugins/ui/lualine.lua
-- ============================================================

return {
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      options = {
        theme = "onedark",
        globalstatus = true,
        disabled_filetypes = {
          statusline = { "dashboard", "snacks_dashboard" },
        },
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = {
          "branch",
          {
            "diff",
            symbols = { added = " ", modified = " ", removed = " " },
          },
          {
            "diagnostics",
            symbols = { error = " ", warn = " ", hint = " ", info = " " },
          },
        },
        lualine_c = {
          { "filename", path = 1, symbols = { modified = "●", readonly = "", unnamed = "" } },
        },
        lualine_x = {
          -- Show macro recording status
          {
            function()
              local reg = vim.fn.reg_recording()
              if reg ~= "" then return "Recording @" .. reg end
              return ""
            end,
            color = { fg = "#ff9e64" },
          },
          -- LSP server name
          {
            function()
              local clients = vim.lsp.get_clients({ bufnr = 0 })
              if #clients == 0 then return "" end
              local names = {}
              for _, c in ipairs(clients) do
                table.insert(names, c.name)
              end
              return " " .. table.concat(names, ", ")
            end,
            color = { fg = "#7dcfff" },
          },
          { "encoding" },
          { "fileformat", icons_enabled = true },
          { "filetype" },
        },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
      },
      extensions = { "lazy", "trouble", "oil" },
    },
  },
}
