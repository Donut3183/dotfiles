require("conform").setup {
  formatters_by_ft = {
    lua = { "stylua" },
    sh = { "shfmt" },
    zsh = { "shfmt" },
    tex = { "latexindent" },
    markdown = { "prettier" },
    c = { "clang-format" },
    cpp = { "clang-format" },
    h = { "clang-format" },
  },

  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 500,
    lsp_fallback = true,
  },
  -- Set default options
  default_format_opts = {
    lsp_format = "fallback",
  },
}
