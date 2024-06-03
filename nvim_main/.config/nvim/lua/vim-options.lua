-- vim.cmd sets vim variables
vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.g.mapleader = " " -- global leader key
vim.cmd("set relativenumber")
vim.cmd("set scrolloff=999")
vim.cmd("set clipboard=unnamedplus")
-- Allow for nice movement on wrapped lines
vim.api.nvim_set_keymap("n", "j", '(v:count || mode(1)[0:1] == "no" ? "j" : "gj")', { noremap = true, expr = true })
vim.api.nvim_set_keymap("n", "k", '(v:count || mode(1)[0:1] == "no" ? "k" : "gk")', { noremap = true, expr = true })
vim.api.nvim_set_keymap("v", "j", '(v:count || mode(1)[0:1] == "\'V\'" ? "j" : "gj")', { noremap = true, expr = true })
vim.api.nvim_set_keymap("v", "k", '(v:count || mode(1)[0:1] == "\'V\'" ? "k" : "gk")', { noremap = true, expr = true })
-- Clear highlights
vim.keymap.set("n", "<Esc>", ":noh<CR>", { desc = "Clear highlights" })

-- Switch between windows
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Window left" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Window down" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Window up" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Window right" })

-- Buffer
vim.keymap.set("n", "<leader>bx", ":bd<CR>", { desc = "Close current buffer" })
vim.keymap.set("n", "<leader>bn", ":enew<CR>", { desc = "Open new buffer" })

vim.keymap.set("n", "<leader>u", "<<", { desc = "Unindent", noremap = true, silent = true })
vim.keymap.set("v", "<leader>u", "<gv", { desc = "Unindent", noremap = true, silent = true })
vim.keymap.set("n", "<leader>i", ">>", { desc = "Indent", noremap = true, silent = true })
vim.keymap.set("v", "<leader>i", ">gv", { desc = "Indent", noremap = true, silent = true })

-- vim.keymap.set("n", "<S-Tab>", "<<", { noremap = true, silent = true })
-- vim.keymap.set("v", "<S-Tab>", "<gv", { noremap = true, silent = true })
