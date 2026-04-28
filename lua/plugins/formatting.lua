-- ============================================================
-- plugins/lsp/formatting.lua — conform.nvim + nvim-lint
-- ============================================================

return {
  -- Formatter
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
      {
        "<leader>cf",
        function()
          require("conform").format({ async = true, lsp_fallback = true })
        end,
        desc = "Format buffer",
      },
    },
    opts = {
      -- Format on save
      format_on_save = {
        timeout_ms = 3000,
        lsp_fallback = true,
      },
      -- Formatter definitions per filetype
      formatters_by_ft = {
        python       = { "ruff_format", "black" },
        javascript   = { "prettier" },
        typescript   = { "prettier" },
        javascriptreact = { "prettier" },
        typescriptreact = { "prettier" },
        html         = { "prettier" },
        css          = { "prettier" },
        scss         = { "prettier" },
        json         = { "prettier" },
        yaml         = { "prettier" },
        markdown     = { "prettier" },
        php          = { "php_cs_fixer" },
        java         = { "google-java-format" },
        sql          = { "sql_formatter" },
        lua          = { "stylua" },
        sh           = { "shfmt" },
        -- Use the first available formatter
        ["_"]        = { "trim_whitespace" },
      },
      -- Custom formatter options
      formatters = {
        black = {
          prepend_args = { "--line-length", "88" },
        },
        php_cs_fixer = {
          args = { "fix", "--rules=@PSR12", "$FILENAME" },
        },
        sql_formatter = {
          prepend_args = { "--language", "sql" },
        },
        stylua = {
          prepend_args = { "--indent-type", "Spaces", "--indent-width", "2" },
        },
      },
    },
  },

  -- Linter (for tools that don't have an LSP)
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPost", "BufWritePost", "BufNewFile" },
    config = function()
      local lint = require("lint")

      lint.linters_by_ft = {
        python     = { "pylint" },
        javascript = { "eslint_d" },
        typescript = { "eslint_d" },
        javascriptreact = { "eslint_d" },
        typescriptreact = { "eslint_d" },
        php        = { "phpcs" },
        sql        = { "sqlfluff" },
      }

      -- Lint on save and when entering a buffer
      local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
      vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
        group = lint_augroup,
        callback = function()
          lint.try_lint()
        end,
      })
    end,
  },
}
