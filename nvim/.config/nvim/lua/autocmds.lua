
-- lua/pontus/autocmds.lua
local augroup = vim.api.nvim_create_augroup
local autocmd  = vim.api.nvim_create_autocmd

local P = augroup("pontus", { clear = true })

-- Auto‑format Lua on save
--autocmd("BufWritePre", {
 -- group   = P,
  --pattern = "*.lua",
  --callback = function() vim.lsp.buf.format() end,
--})

-- Highlight yanks
autocmd("TextYankPost", {
  group    = P,
  callback = function() vim.highlight.on_yank{ timeout = 200 } end,
})
