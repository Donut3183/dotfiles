-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()
local lspconfig = require "lspconfig"

-- EXAMPLE
local servers = { "matlab_ls", "bashls", "clangd", "pyright" }
local nvlsp = require "nvchad.configs.lspconfig"

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }
end

-- require("lspconfig").ltex.setup {
--   on_attach = nvlsp.on_attach,
--   on_init = nvlsp.on_init,
--   capabilities = nvlsp.capabilities,
--   settings = {
--     ltex = {
--       language = "en-GB",
--       additionalRules = {
--         enablePickyRules = true, -- Optional: enables stricter checks
--       },
--     },
--   },
  -- cmd = { "ltex-ls" },
  -- filetypes = { "markdown", "text", "tex" },
  -- flags = { debounce_text_changes = 300 },
-- }
require("ltex_extra").setup {
  -- your_ltex_extra_opts,
  load_langs = { "en-US" },
  server_opts = {
    capabilities = nvlsp.capabilities,
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    settings = {
      ltex = {
        init_check = true,
        language = "en-US",
        additionalRules = {
          enablePickyRules = true, -- Optional: enables stricter checks
          languageModel = '~/.ngrams/',
        },
      },
    },
  },
}
-- lspconfig.matlab_ls.setup {
--   on_attach = nvlsp.on_attach,
--   on_init = nvlsp.on_init,
--   capabilities = nvlsp.capabilities,
--   settings = {
--     matlab = {
--       indexWorkspace = true,
--       installPath = "/usr/local/MATLAB/R2024a/",
--       matlabConnectionTiming = "onStart",
--       telemetry = true,
--     },
--   },
-- }
-- configuring single server, example: typescript
-- lspconfig.ts_ls.setup {
--   on_attach = nvlsp.on_attach,
--   on_init = nvlsp.on_init,
--   capabilities = nvlsp.capabilities,
-- }
