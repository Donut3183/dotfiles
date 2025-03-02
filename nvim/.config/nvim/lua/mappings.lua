require "nvchad.mappings"
local wk = require "which-key"
wk.add {
  {
    { "<leader>c", group = "ChatGPT" },
    { "<leader>cc", "<cmd>ChatGPT<CR>", desc = "ChatGPT" },
    {
      mode = { "n", "v" },
      -- { "<leader>ca", "<cmd>ChatGPTRun add_tests<CR>", desc = "Add Tests" },
      -- { "<leader>cd", "<cmd>ChatGPTRun docstring<CR>", desc = "Docstring" },
      { "<leader>ce", "<cmd>ChatGPTEditWithInstruction<CR>", desc = "Edit with instruction" },
      { "<leader>cf", "<cmd>ChatGPTRun fix_bugs<CR>", desc = "Fix Bugs" },
      { "<leader>cg", "<cmd>ChatGPTRun grammar_correction<CR>", desc = "Grammar Correction" },
      { "<leader>ck", "<cmd>ChatGPTRun keywords<CR>", desc = "Keywords" },
      { "<leader>cl", "<cmd>ChatGPTRun code_readability_analysis<CR>", desc = "Code Readability Analysis" },
      { "<leader>co", "<cmd>ChatGPTRun optimize_code<CR>", desc = "Optimize Code" },
      { "<leader>cr", "<cmd>ChatGPTRun roxygen_edit<CR>", desc = "Roxygen Edit" },
      { "<leader>cs", "<cmd>ChatGPTRun summarize<CR>", desc = "Summarize" },
      { "<leader>ct", "<cmd>ChatGPTRun translate<CR>", desc = "Translate" },
      { "<leader>cp", "<cmd>ChatGPTRun paraphrase<CR>", desc = "Paraphrase" },
      { "<leader>cx", "<cmd>ChatGPTRun explain_code<CR>", desc = "Explain Code" },
    },
  },
}
-- add yours here

local map = vim.keymap.set
map("n", ";", ":", { desc = "CMD enter command mode" })

map({ "n", "v" }, "j", "v:count == 0 ? 'gj' : 'j'", { noremap = true, expr = true })
map({ "n", "v" }, "k", "v:count == 0 ? 'gk' : 'k'", { noremap = true, expr = true })
