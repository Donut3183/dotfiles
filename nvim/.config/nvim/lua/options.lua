require "nvchad.options"

-- add yours here!
local o = vim.o
local opt = vim.opt
o.cursorlineopt = 'both' -- to enable cursorline!
o.clipboard = "unnamedplus"
opt.wrap = true
opt.linebreak = true    -- Prevent breaking in the middle of words
opt.breakindent = true  -- Indent wrapped lines for readability

-- Additional options for C/C++ files:
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "c", "cpp" },
  callback = function()
    vim.opt_local.cindent = true              -- Enable C-style indentation
    vim.opt_local.tabstop = 4                 -- A tab appears as 4 spaces
    vim.opt_local.shiftwidth = 4              -- One indent level is 4 spaces
    vim.opt_local.expandtab = false           -- Use literal tab characters (set to true if you prefer spaces)
    vim.opt_local.cinoptions = ":0,p0,t0"     -- Fine-tune cindent behavior (customize as needed)
    vim.opt_local.textwidth = 120             -- Set a longer line width for formatting (e.g., 120 columns)
  end,
})

-- vim.api.nvim_create_autocmd("VimEnter", {
--   callback = function()
--     if vim.fn.argc() == 0 then
--       vim.cmd("NvimTreeOpen")
--     end
--   end,
-- })
