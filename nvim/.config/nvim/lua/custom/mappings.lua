---@type MappingsTable
local M = {}

M.override = {
	n = {
		["<leader>nT"] = { "<cmd> set nu! <CR>", "Toggle line number" },
	},
}

M.groups = {
	plugin = true,
	n = {
		["<leader>"] = {
			n = { name = "+neorg" },
		},
	},
}
M.neorg = {
	n = {
		["<leader>nn"] = { "<cmd>Neorg keybind norg core.dirman.new.note<CR>", "New Note" },
		["<leader>ni"] = { "<cmd>Neorg index<CR>", "Go to index" },
		["<leader>nj"] = { "<cmd>Neorg keybind norg core.integrations.treesitter.next.heading<CR>", "Next Heading" },
		["<leader>nk"] = {
			"<cmd>Neorg keybind norg core.integrations.treesitter.previous.heading<CR>",
			"Previous Heading",
		},
		["<leader>nh"] = { "<cmd>Neorg keybind norg core.integrations.treesitter.next.link<CR>", "Next Link" },
		["<leader>nl"] = { "<cmd>Neorg keybind norg core.integrations.treesitter.previous.link<CR>", "Previous Link" },
		["<leader>ng"] = { "<cmd>Neorg keybind norg core.esupports.hop.hop-link<CR>", "Hop Link" },
		["<leader>nN"] = { "<cmd>Neorg keybind norg core.itero.next-iteration<CR>", "Itero next-iteration" },
		["<leader>nS"] = { "<cmd>Neorg keybind norg core.itero.stop-iteration<CR>", "Itero stop-iteration" },
		["<leader>nm"] = { "<cmd>Neorg keybind norg core.looking-glass.magnify-code-block<CR>", "Magnify Code Block" },
		["<leader>nr"] = { "<cmd>Neorg keybind norg core.pivot.invert-list-type<CR>", "Invert list" },
		["<leader>nL"] = { "<cmd>Neorg keybind norg core.pivot.toggle-list-type<CR>", "Toggle list" },
		["<leader>npr"] = { "<cmd>Neorg keybind norg core.promo.promote_range<CR>", "Promote Range" },
		["<leader>np"] = { "<cmd>Neorg keybind norg core.promo.promote<CR>", "Promote" },
		["<leader>nd"] = { "<cmd>Neorg keybind norg core.promo.demote<CR>", "Demote" },
		["<leader>ndr"] = { "<cmd>Neorg keybind norg core.promo.demote_range<CR>", "Demote Range" },
		["<leader>ntC"] = {
			"<cmd>Neorg keybind norg core.qol.todo_items.todo.task_cycle_reverse<CR>",
			"TODO Cycle Reverse",
		},
		["<leader>ntc"] = { "<cmd>Neorg keybind norg core.qol.todo_items.todo.task_cycle<CR>", "TODO Cycle" },
		["<leader>ntp"] = { "<cmd>Neorg keybind norg core.qol.todo_items.todo.task_pending<CR>", "TODO Pending" },
		["<leader>nta"] = { "<cmd>Neorg keybind norg core.qol.todo_items.todo.task_ambiguous<CR>", "TODO Ambiguous" },
		["<leader>ntu"] = { "<cmd>Neorg keybind norg core.qol.todo_items.todo.task_undone<CR>", "TODO Undone" },
		["<leader>ntI"] = { "<cmd>Neorg keybind norg core.qol.todo_items.todo.task_important<CR>", "TODO Important" },
		["<leader>ntR"] = { "<cmd>Neorg keybind norg core.qol.todo_items.todo.task_recurring<CR>", "TODO Recurring" },
		["<leader>ntS"] = { "<cmd>Neorg keybind norg core.qol.todo_items.todo.task_cancelled<CR>", "TODO Cancelled" },
		["<leader>ntP"] = { "<cmd>Neorg keybind norg core.qol.todo_items.todo.task_on_hold<CR>", "TODO On Hold" },
		["<leader>ntD"] = { "<cmd>Neorg keybind norg core.qol.todo_items.todo.task_done<CR>", "TODO Done" },
	},
}

M.general = {
	n = {
		[";"] = { ":", "enter command mode", opts = { nowait = true } },
		-- ["<C-b>"] = { "mpea**<Esc>bi**<Esc>`p<CR>", "Toggle markdown Bold" },
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
		["<leader>lp"] = {
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
