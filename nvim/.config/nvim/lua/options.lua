require "nvchad.options"

-- add yours here!
local o = vim.o
local opt = vim.opt
o.cursorlineopt = 'both' -- to enable cursorline!
o.clipboard = "unnamedplus"
opt.wrap = true
opt.linebreak = true    -- Prevent breaking in the middle of words
opt.breakindent = true  -- Indent wrapped lines for readability
