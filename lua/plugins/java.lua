-- ============================================================
-- plugins/lsp/java.lua — Java LSP via nvim-jdtls
-- ============================================================
-- jdtls needs to be managed separately from lspconfig because
-- it requires per-project workspace directories and special
-- setup on BufEnter rather than the normal lspconfig flow.

return {
  {
    "mfussenegger/nvim-jdtls",
    ft = "java",
    config = function()
      local jdtls = require("jdtls")
      local mason_registry = require("mason-registry")

      -- Find jdtls install path via mason
      local jdtls_pkg = mason_registry.get_package("jdtls")
      local jdtls_path = jdtls_pkg:get_install_path()

      -- Project-specific workspace directory
      local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
      local workspace_dir = vim.fn.stdpath("data") .. "/jdtls-workspace/" .. project_name

      -- Find the correct launcher jar
      local launcher = vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar")

      -- Detect OS for config path
      local config_path
      local os_name = vim.loop.os_uname().sysname
      if os_name == "Linux" then
        config_path = jdtls_path .. "/config_linux"
      elseif os_name == "Darwin" then
        config_path = jdtls_path .. "/config_mac"
      else
        config_path = jdtls_path .. "/config_win"
      end

      local config = {
        cmd = {
          "java",
          "-Declipse.application=org.eclipse.jdt.ls.core.id1",
          "-Dosgi.bundles.defaultStartLevel=4",
          "-Declipse.product=org.eclipse.jdt.ls.core.product",
          "-Dlog.protocol=true",
          "-Dlog.level=ALL",
          "-Xmx1g",
          "--add-modules=ALL-SYSTEM",
          "--add-opens", "java.base/java.util=ALL-UNNAMED",
          "--add-opens", "java.base/java.lang=ALL-UNNAMED",
          "-jar", launcher,
          "-configuration", config_path,
          "-data", workspace_dir,
        },
        root_dir = require("jdtls.setup").find_root({
          ".git", "mvnw", "gradlew", "pom.xml", "build.gradle"
        }),
        settings = {
          java = {
            signatureHelp = { enabled = true },
            contentProvider = { preferred = "fernflower" },
            completion = {
              favoriteStaticMembers = {
                "org.junit.Assert.*",
                "org.junit.Assume.*",
                "org.junit.jupiter.api.Assertions.*",
                "org.mockito.Mockito.*",
              },
            },
            sources = {
              organizeImports = {
                starThreshold = 9999,
                staticStarThreshold = 9999,
              },
            },
            codeGeneration = {
              toString = { template = "${object.className}{${member.name()}=${member.value}, }" },
              useBlocks = true,
            },
          },
        },
        on_attach = function(_, bufnr)
          jdtls.setup_dap({ hotcodereplace = "auto" })
          jdtls.setup.add_commands()

          local map = function(keys, func, desc)
            vim.keymap.set("n", keys, func, { buffer = bufnr, desc = "Java: " .. desc })
          end

          map("<leader>jo", jdtls.organize_imports, "Organize imports")
          map("<leader>jv", jdtls.extract_variable, "Extract variable")
          map("<leader>jc", jdtls.extract_constant, "Extract constant")
          map("<leader>jm", jdtls.extract_method, "Extract method")
          map("<leader>jt", jdtls.test_nearest_method, "Test nearest method")
          map("<leader>jT", jdtls.test_class, "Test class")
        end,
        capabilities = require("blink.cmp").get_lsp_capabilities(),
      }

      -- Start or attach jdtls
      jdtls.start_or_attach(config)

      -- Re-attach on BufEnter for java files
      vim.api.nvim_create_autocmd("BufEnter", {
        pattern = "*.java",
        callback = function()
          jdtls.start_or_attach(config)
        end,
      })
    end,
  },
}
