return {
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    config = function()
      -- Install parsers (no-op if already installed)
      require("nvim-treesitter").install({
        "html", "css", "javascript", "typescript", "tsx",
        "python", "php", "java", "lua",
        "sql", "json", "yaml", "toml", "xml",
        "markdown", "markdown_inline",
        "bash",
        "gitignore", "gitcommit",
      })

      -- Enable treesitter highlighting and indentation per filetype
      vim.api.nvim_create_autocmd("FileType", {
        pattern = {
          "html", "css", "javascript", "typescript", "tsx",
          "python", "php", "java", "lua",
          "sql", "json", "yaml", "toml", "xml",
          "markdown",
          "bash", "sh",
          "gitcommit",
        },
        callback = function()
          vim.treesitter.start()
          vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
      })

      -- Textobjects setup
      require("nvim-treesitter-textobjects").setup({
        select = {
          lookahead = true,
          keymaps = {
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["ac"] = "@class.outer",
            ["ic"] = "@class.inner",
            ["aa"] = "@parameter.outer",
            ["ia"] = "@parameter.inner",
            ["ab"] = "@block.outer",
            ["ib"] = "@block.inner",
          },
        },
        move = {
          enable = true,
          set_jumps = true,
          goto_next_start = {
            ["]f"] = "@function.outer",
            ["]c"] = "@class.outer",
          },
          goto_next_end = {
            ["]F"] = "@function.outer",
            ["]C"] = "@class.outer",
          },
          goto_previous_start = {
            ["[f"] = "@function.outer",
            ["[c"] = "@class.outer",
          },
          goto_previous_end = {
            ["[F"] = "@function.outer",
            ["[C"] = "@class.outer",
          },
        },
        swap = {
          enable = true,
          swap_next = { ["<leader>sn"] = "@parameter.inner" },
          swap_previous = { ["<leader>sp"] = "@parameter.inner" },
        },
      })
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter-context",
    lazy = false,
    opts = {
      enable = true,
      max_lines = 3,
      trim_scope = "outer",
    },
  },
}
