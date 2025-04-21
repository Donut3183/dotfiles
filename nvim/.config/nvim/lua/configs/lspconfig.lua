-- load defaults i.e lua_lsp
local lspconfig = require "lspconfig"

local servers = { "matlab_ls", "bashls", "clangd", "pyright" }

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
  }
end


require("ltex_extra").setup {
  load_langs = { "en-US" },
  server_opts = {
    capabilities = capabilities,
    on_attach = on_attach,
    on_init = on_init,
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

