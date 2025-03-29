vim.g.vimtex_compiler_method = "latexmk"

vim.g.vimtex_compiler_latexmk = {
  build_dir = "", -- Specify build directory if needed
  options = {
    "-lualatex",
    "-interaction=nonstopmode",
    "-synctex=1",
    "-shell-escape",
  },
}

-- Automatically run makeglossaries after compilation
vim.g.vimtex_compiler_latexmk_engines = {
  _ = "-lualatex",
}

vim.g.vimtex_quickfix_enabled = 0
vim.g.vimtex_quickfix_autoclose_after_keystrokes = 1

-- Viewer configuration with forward and inverse search for zathura
vim.g.vimtex_view_method = "zathura"
vim.g.vimtex_view_general_options = [[
  --unique
  file:@pdf\#src:@line@tex
]]
