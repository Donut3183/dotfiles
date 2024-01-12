-- vim.cmd sets vim variables
vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.g.mapleader = " " -- global leader key
vim.cmd("set relativenumber")
vim.cmd("set scrolloff=999")

-- Allow for nice movement on wrapped lines
vim.api.nvim_set_keymap("n", "j", '(v:count ? "j" : "gj")', { noremap = true, expr = true })
vim.api.nvim_set_keymap("n", "k", '(v:count ? "k" : "gk")', { noremap = true, expr = true })

-- Clear highlights
vim.keymap.set("n", "<Esc>", ":noh<CR>", { desc = "Clear highlights" })

-- Switch between windows
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Window left" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Window down" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Window up" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Window right" })
