---@type MappingsTable
local M = {}

M.general = {
	n = {
		[";"] = { ":", "enter command mode", opts = { nowait = true } },
		-- ["<C-b>"] = { "mpea**<Esc>bi**<Esc>`p<CR>", "Toggle markdown Bold" },
	},
}
M.markdownpreview = {
	n = {
		["<leader>mp"] = { ":MarkdownPreviewToggle<CR>", "Toggle Markdown Preview" },
	},
}

local customConform = require("custom.configs.conform") -- get your custom settings
M.conform = {
	n = {
		["<leader>fm"] = {
			function()
				require("conform").format(customConform.conform_format_settings) -- call conform's format method
			end,
			"Conform formatting",
		},
	},
	v = {
		["<leader>fm"] = {
			function()
				require("conform").format(customConform.conform_format_settings) -- call conform's format method
			end,
			"Conform formatting",
		},
	},
}
local linters = require("custom.configs.linting")
M.linting = {
	n = {
		["<leader>ll"] = {
			function()
				local lint = require("lint")
				lint.linters_by_ft = linters.linters
				lint.try_lint()
			end,
			"Enable linting",
		},
	},
}
M.chatgpt = {
	n = {
		["<leader>gg"] = { "<cmd>ChatGPT<CR>", "ChatGPT" },
		["<leader>ge"] = { "<cmd>ChatGPTEditWithInstruction<CR>", "Edit with instruction" },
		["<leader>gc"] = { "<cmd>ChatGPTRun grammar_correction<CR>", "Grammar Correction" },
		["<leader>gt"] = { "<cmd>ChatGPTRun translate<CR>", "Translate" },
		["<leader>gk"] = { "<cmd>ChatGPTRun keywords<CR>", "Keywords" },
		["<leader>gd"] = { "<cmd>ChatGPTRun docstring<CR>", "Docstring" },
		["<leader>ga"] = { "<cmd>ChatGPTRun add_tests<CR>", "Add Tests" },
		["<leader>go"] = { "<cmd>ChatGPTRun optimize_code<CR>", "Optimize Code" },
		["<leader>gs"] = { "<cmd>ChatGPTRun summarize<CR>", "Summarize" },
		["<leader>gf"] = { "<cmd>ChatGPTRun fix_bugs<CR>", "Fix Bugs" },
		["<leader>gx"] = { "<cmd>ChatGPTRun explain_code<CR>", "Explain Code" },
		["<leader>gr"] = { "<cmd>ChatGPTRun roxygen_edit<CR>", "Roxygen Edit" },
		["<leader>gl"] = { "<cmd>ChatGPTRun code_readability_analysis<CR>", "Code Readability Analysis" },
		["<leader>gn"] = { "<cmd>ChatGPTCompleteCode<CR>", "Complete The Code" },
		["<leader>gp"] = { "<cmd>ChatGPTActAs<CR>", "Roleplay as ..." },
	},
	v = {
		["<leader>gg"] = { "<cmd>ChatGPT<CR>", "ChatGPT" },
		["<leader>ge"] = { "<cmd>ChatGPTEditWithInstruction<CR>", "Edit with instruction" },
		["<leader>gc"] = { "<cmd>ChatGPTRun grammar_correction<CR>", "Grammar Correction" },
		["<leader>gt"] = { "<cmd>ChatGPTRun translate<CR>", "Translate" },
		["<leader>gk"] = { "<cmd>ChatGPTRun keywords<CR>", "Keywords" },
		["<leader>gd"] = { "<cmd>ChatGPTRun docstring<CR>", "Docstring" },
		["<leader>ga"] = { "<cmd>ChatGPTRun add_tests<CR>", "Add Tests" },
		["<leader>go"] = { "<cmd>ChatGPTRun optimize_code<CR>", "Optimize Code" },
		["<leader>gs"] = { "<cmd>ChatGPTRun summarize<CR>", "Summarize" },
		["<leader>gf"] = { "<cmd>ChatGPTRun fix_bugs<CR>", "Fix Bugs" },
		["<leader>gx"] = { "<cmd>ChatGPTRun explain_code<CR>", "Explain Code" },
		["<leader>gr"] = { "<cmd>ChatGPTRun roxygen_edit<CR>", "Roxygen Edit" },
		["<leader>gl"] = { "<cmd>ChatGPTRun code_readability_analysis<CR>", "Code Readability Analysis" },
		["<leader>gn"] = { "<cmd>ChatGPTCompleteCode<CR>", "Complete The Code" },
		["<leader>gp"] = { "<cmd>ChatGPTActAs<CR>", "Roleplay as ..." },
	},
}

return M
