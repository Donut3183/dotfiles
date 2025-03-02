-- EXAMPLE
local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"
local servers = { "html", "cssls", "matlab_ls", "bashls", "clangd", "pyright", "jsonls", "yamlls", "dockerls"}

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
  }
end

lspconfig.matlab_ls.setup {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
  settings = {
    matlab = {
      indexWorkspace = true,
      installPath = "/usr/local/MATLAB/R2024a/",
      matlabConnectionTiming = "onStart",
      telemetry = true,
    },
  },
}
