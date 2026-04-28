-- ============================================================
-- plugins/ui/colorizer.lua — Inline CSS/hex color preview
-- ============================================================

return {
  {
    "NvChad/nvim-colorizer.lua",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      filetypes = {
        "*",             -- all filetypes
        css  = { css = true },
        scss = { css = true },
        less = { css = true },
        html = { names = false },
      },
      user_default_options = {
        RGB      = true,   -- #RGB hex codes
        RRGGBB   = true,   -- #RRGGBB hex codes
        names    = true,   -- CSS color names (blue, red, etc.)
        RRGGBBAA = true,   -- #RRGGBBAA hex codes
        rgb_fn   = true,   -- CSS rgb() / rgba() functions
        hsl_fn   = true,   -- CSS hsl() / hsla() functions
        css      = true,   -- Enable all CSS features
        css_fn   = true,   -- Enable all CSS functions
        mode     = "background", -- background | foreground | virtualtext
        tailwind = true,   -- highlight tailwind colors
        virtualtext = "■",
      },
    },
  },
}
