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
      { "<leader>cr", "<cmd>ChatGPTRun reduce_passive_voice<CR>", desc = "Rewrites text to reduce passive voice" },
      { "<leader>ci", "<cmd>ChatGPTRun citation_format<CR>", desc = "Ensures all citations follow IEEE" },
      { "<leader>cme", "<cmd>ChatGPTRun math_check<CR>", desc = "Checks and corrects LaTeX math equations" },
      { "<leader>cs", "<cmd>ChatGPTRun summarize<CR>", desc = "Summarize" },
      { "<leader>ct", "<cmd>ChatGPTRun academic_style<CR>", desc = "Converts informal into formal academic tone" },
      { "<leader>cp", "<cmd>ChatGPTRun paraphrase<CR>", desc = "Paraphrase" },
      { "<leader>cx", "<cmd>ChatGPTRun explain_code<CR>", desc = "Explain Code" },
    },
  },
}
-- add yours here

local map = vim.keymap.set

map("n", "<C-t>", "<cmd>tabnew<CR>", { desc = "Create new tab" })
-- Map "gs" to search the current word under the cursor (like the "*" command)
map("n", "gs", "*", { desc = "Search current word under cursor" })
map("n", ";", ":", { desc = "CMD enter command mode" })

map({ "n", "v" }, "j", "v:count == 0 ? 'gj' : 'j'", { noremap = true, expr = true })
map({ "n", "v" }, "k", "v:count == 0 ? 'gk' : 'k'", { noremap = true, expr = true })

