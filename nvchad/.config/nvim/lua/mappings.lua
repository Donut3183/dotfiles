require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
-- Navigate softwrapped lines
map({ "n", "v" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true })
map({ "n", "v" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true })
-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
