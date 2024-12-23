local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    sh = { "shfmt" },
    zsh = { "shfmt" },
    -- python = { "autopep8" }
    -- css = { "prettier" },
    -- html = { "prettier" },
    latex = { "llf" },
  },

  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 500,
    lsp_fallback = true,
  },
}

require("conform").setup(options)
