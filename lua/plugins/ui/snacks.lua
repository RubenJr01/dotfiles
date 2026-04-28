-- ============================================================
-- plugins/ui/snacks.lua — folke/snacks.nvim (all modules)
-- ============================================================
-- snacks.nvim must be lazy = false and priority = 1000
-- so it initializes before everything else.

return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      -- ── Core modules ──────────────────────────────────────

      -- Faster file loading (disables heavy features for large files)
      bigfile = { enabled = true },

      -- Quick file open without triggering all autocmds
      quickfile = { enabled = true },

      -- ── UI modules ────────────────────────────────────────

      -- Dashboard / start screen
      dashboard = {
        enabled = true,
        width = 60,
        preset = {
          keys = {
            { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.picker.files()" },
            { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
            { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.picker.recent()" },
            { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.picker.grep()" },
            { icon = " ", key = "c", desc = "Config", action = ":lua Snacks.picker.files({ cwd = vim.fn.stdpath('config') })" },
            { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy" },
            { icon = " ", key = "m", desc = "Mason", action = ":Mason" },
            { icon = " ", key = "q", desc = "Quit", action = ":qa" },
          },
        }
      },

      sections = {
        { section = "header" },
        { section = "keys",   gap = 1, padding = 1 },
        { section = "startup" },

        {
          section = "terminal",
          cmd = "pokemon-colorscripts -r --no-title; sleep .1",
          random = 10,
          pane = 2,
          indent = 4,
          height = 30,
        },
      },

      -- Replaces nvim-notify
      notifier = {
        enabled = true,
        timeout = 3000,
        style = "compact",
        top_down = false, -- notifications appear bottom-right
      },

      -- Replaces indent-blankline
      indent = {
        enabled = true,
        indent = {
          char = "│",
          hl = "SnacksIndent",
        },
        scope = {
          enabled = true,
          char = "│",
          hl = "SnacksIndentScope",
        },
      },

      -- Smooth scrolling
      scroll = { enabled = true },

      -- Scope detection (used by indent scope highlight)
      scope = { enabled = true },

      -- Highlights other occurrences of the word under cursor
      words = {
        enabled = true,
        debounce = 200,
      },

      -- Replaces dressing.nvim vim.ui.input
      input = { enabled = true },

      -- Enhanced statuscolumn (signs, folds, line numbers)
      statuscolumn = {
        enabled = true,
        left    = { "mark", "sign" },
        right   = { "fold", "git" },
        folds   = {
          open = false,
          git_hl = false,
        },
        git     = {
          patterns = { "GitSign", "MiniDiffSign" },
        },
      },

      -- Zen / focus mode
      zen = {
        enabled = true,
        toggles = {
          dim = true,
          git_signs = false,
          mini_diff_signs = false,
          diagnostics = false,
          inlay_hints = false,
        },
        show = {
          statusline = false,
          tabline = false,
        },
        win = {
          backdrop = { transparent = true, blend = 40 },
          width = 120,
        },
      },

      -- Dim inactive code (used by zen mode)
      dim = { enabled = true },

      -- ── Terminal ─────────────────────────────────────────
      -- Replaces toggleterm.nvim
      terminal = {
        enabled = true,
        win = {
          position = "bottom",
          height = 0.3,
          border = "rounded",
        },
      },

      -- ── Git ───────────────────────────────────────────────
      -- Replaces lazygit.nvim
      lazygit = {
        enabled = true,
        win = {
          width = 0,
          height = 0,
          border = "rounded",
        },
      },

      -- Open current file/repo in browser (GitHub, GitLab, etc.)
      gitbrowse = { enabled = true },

      -- ── Picker (fuzzy finder) ─────────────────────────────
      -- Full Telescope-like fuzzy finder built into snacks
      picker = {
        enabled = true,
        ui_select = true, -- replace vim.ui.select
        win = {
          input = {
            keys = {
              ["<Esc>"] = { "close", mode = { "n", "i" } },
            },
          },
        },
        layout = {
          preset = "default",
          cycle = true,
        },
        icons = {
          diagnostics = {
            Error = " ",
            Warn  = " ",
            Hint  = " ",
            Info  = " ",
          },
          git = {
            added     = " ",
            changed   = " ",
            deleted   = " ",
            ignored   = " ",
            renamed   = " ",
            staged    = " ",
            unstaged  = "󱈸 ",
            untracked = " ",
          },
        },
      },

      -- ── Explorer ──────────────────────────────────────────
      -- File explorer (oil.nvim-style buffer editing)
      explorer = {
        enabled = true,
        replace_netrw = true,
      },

      -- ── Scratch buffers ───────────────────────────────────
      scratch = { enabled = true },

      -- ── Animation ─────────────────────────────────────────
      animate = { enabled = true },

      -- ── Windows ───────────────────────────────────────────
      win = { enabled = true },

      -- ── Profiler (dev tool) ───────────────────────────────
      profiler = { enabled = false }, -- enable when needed
    },

    keys = {
      -- ── Picker keymaps ────────────────────────────────────
      { "<leader>ff", function() Snacks.picker.files() end,                                   desc = "Find files" },
      { "<leader>fg", function() Snacks.picker.grep() end,                                    desc = "Grep (live)" },
      { "<leader>fw", function() Snacks.picker.grep_word() end,                               desc = "Grep word under cursor",      mode = { "n", "x" } },
      { "<leader>fb", function() Snacks.picker.buffers() end,                                 desc = "Buffers" },
      { "<leader>fr", function() Snacks.picker.recent() end,                                  desc = "Recent files" },
      { "<leader>fc", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "Find config file" },
      { "<leader>fp", function() Snacks.picker.projects() end,                                desc = "Projects" },
      { "<leader>fh", function() Snacks.picker.help() end,                                    desc = "Help pages" },
      { "<leader>fk", function() Snacks.picker.keymaps() end,                                 desc = "Keymaps" },
      { "<leader>fd", function() Snacks.picker.diagnostics() end,                             desc = "Diagnostics" },
      { "<leader>fs", function() Snacks.picker.lsp_symbols() end,                             desc = "LSP symbols" },
      { "<leader>fS", function() Snacks.picker.lsp_workspace_symbols() end,                   desc = "LSP workspace symbols" },
      { "<leader>f/", function() Snacks.picker.search_history() end,                          desc = "Search history" },
      { "<leader>gc", function() Snacks.picker.git_log() end,                                 desc = "Git commits" },
      { "<leader>gs", function() Snacks.picker.git_status() end,                              desc = "Git status" },

      -- ── Explorer ──────────────────────────────────────────
      { "<leader>e",  function() Snacks.explorer() end,                                       desc = "File explorer" },

      -- ── Git ───────────────────────────────────────────────
      { "<leader>gg", function() Snacks.lazygit() end,                                        desc = "Lazygit" },
      { "<leader>gB", function() Snacks.gitbrowse() end,                                      desc = "Git browse (open in browser)" },

      -- ── Terminal ──────────────────────────────────────────
      { "<C-\\>",     function() Snacks.terminal() end,                                       desc = "Toggle terminal",             mode = { "n", "t" } },
      { "<leader>tf", function() Snacks.terminal.open() end,                                  desc = "Float terminal" },

      -- ── Notifications ─────────────────────────────────────
      { "<leader>un", function() Snacks.notifier.show_history() end,                          desc = "Notification history" },
      { "<leader>ux", function() Snacks.notifier.hide() end,                                  desc = "Dismiss notifications" },

      -- ── Zen / focus ───────────────────────────────────────
      { "<leader>z",  function() Snacks.zen() end,                                            desc = "Zen mode" },
      { "<leader>Z",  function() Snacks.zen.zoom() end,                                       desc = "Zoom (current window)" },

      -- ── Scratch ───────────────────────────────────────────
      { "<leader>.",  function() Snacks.scratch() end,                                        desc = "Scratch buffer" },
      { "<leader>S",  function() Snacks.scratch.select() end,                                 desc = "Select scratch buffer" },

      -- ── Rename (LSP-aware) ────────────────────────────────
      { "<leader>rr", function() Snacks.rename.rename_file() end,                             desc = "Rename file" },

      -- ── Word highlight navigation ─────────────────────────
      { "]]",         function() Snacks.words.jump(vim.v.count1) end,                         desc = "Next word reference",         mode = { "n", "t" } },
      { "[[",         function() Snacks.words.jump(-vim.v.count1) end,                        desc = "Prev word reference",         mode = { "n", "t" } },

      -- ── Toggle helpers ────────────────────────────────────
      { "<leader>us", function() Snacks.toggle.option("spell") end,                           desc = "Toggle spell check" },
      { "<leader>uw", function() Snacks.toggle.option("wrap") end,                            desc = "Toggle word wrap" },
      { "<leader>ul", function() Snacks.toggle.line_number() end,                             desc = "Toggle line numbers" },
      { "<leader>ud", function() Snacks.toggle.diagnostics() end,                             desc = "Toggle diagnostics" },
      { "<leader>uh", function() Snacks.toggle.inlay_hints() end,                             desc = "Toggle inlay hints" },
      { "<leader>uZ", function() Snacks.toggle.zen() end,                                     desc = "Toggle zen mode" },
    },

    init = function()
      vim.api.nvim_create_autocmd("User", {
        pattern = "VeryLazy",
        callback = function()
          -- Set vim.notify to snacks notifier
          vim.notify = Snacks.notify

          -- Debug helpers (available in dev)
          _G.dd = function(...) Snacks.debug.inspect(...) end
          _G.bt = function() Snacks.debug.backtrace() end
          vim.print = _G.dd
        end,
      })
    end,
  },
}
