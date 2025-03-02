vim.g.vimtex_view_method = "zathura"
vim.g.vimtex_view_general_options = '--synctex-forward @line:@col:@tex --synctex-editor-command "nvim +%{line} %{input}" @pdf --unique'
vim.g.vimtex_compiler_method = "latexmk"
-- Configure latexmk to use lualatex
vim.g.vimtex_compiler_latexmk = {
  build_dir = "",  -- Optional: specify a custom build directory if desired
  continuous = 1,
  executable = "latexmk",
  options = {
    "-shell-escape",
    "-verbose",
    "-file-line-error",
    "-synctex=1",
    "-interaction=nonstopmode",
    "-lualatex"  -- Use lualatex as the engine
  },
}

-- Explicitly set the latexmk engine
vim.g.vimtex_compiler_latexmk_engines = {
  _ = "-lualatex"  -- Set lualatex as the default engine
}
vim.g.vimtex_quickfix_enabled = 0
vim.g.vimtex_quickfix_autoclose_after_keystrokes = 1
