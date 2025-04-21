local M = {}

function M.setup()
  local map = vim.keymap.set
  local opts = { noremap = true, silent = true }

  -- Disable space in normal mode
  map("n", "<Space>", "<Nop>", { silent = true })
  map("n", "<Esc>", ":noh<CR>", { silent = true , desc = "Clear search highlight"})

  -- MiniFiles
  map("n", "<leader>e", function() require("mini.files").open() end, { desc = "Open Files" })
  map("n", "<leader>E", function() require("mini.files").close() end, { desc = "Close Files" })
  map("n", "<C-n>", function() require("mini.files").open() end, { desc = "Open Files" })

  -- File commands
  map("n", "<leader>w", ":w<CR>", { desc = "Save file", silent = true })
  map("n", "<leader>q", ":q<CR>", { desc = "Quit", silent = true })

  -- Tab navigation
  map("n", "<Tab>", ":bnext<CR>", { desc = "Next Tab", silent = true })
  map("n", "<S-Tab>", ":bprevious<CR>", { desc = "Previous Tab", silent = true })
  map("n", "<C-t>", ":tabnew<CR>", { desc = "New Tab", silent = true })

  -- Starter screen
  map("n", "<leader>S", function() require("mini.starter").open() end, { desc = "Open Starter" })

  print("Keymappings loaded from mappings!")
end

return M

