local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later

-- Make 'mini.nvim' part of the 'mini-deps-snap'
-- Use 'HEAD' because I dont want to follow main
add({ name = "mini.nvim", checkout = "HEAD" })

-- Step one
now(function()
	require("mini.basics").setup({
		-- Manage options manually in a spirit of transparency
		options = { basic = false },
		mappings = { windows = true, move_with_alt = true },
		autocommands = { relnum_in_visual_mode = true },
	})
end)

-- Mini.notify
now(function()
	local not_lua_diagnosing = function(notif)
		return not vim.startswith(notif.msg, "lua_ls: Diagnosing")
	end
	local filterout_lua_diagnosing = function(notif_arr)
		return MiniNotify.default_sort(vim.tbl_filter(not_lua_diagnosing, notif_arr))
	end
	require("mini.notify").setup({
		content = { sort = filterout_lua_diagnosing },
		window = { config = { border = "double" } },
	})
	vim.notify = MiniNotify.make_notify()
end)

-- Mini.sessions
now(function()
	require("mini.sessions").setup()
end)
-- Mini.starter
now(function()
	require("mini.starter").setup()
end)
-- Mini.statusline
now(function()
	require("mini.statusline").setup()
end)
-- Mini.tabline
now(function()
	require("mini.tabline").setup()
end)
-- Mini.icons
now(function()
	require("mini.icons").setup({
		use_file_extension = function(ext, _)
			local suf3, suf4 = ext:sub(-3), ext:sub(-4)
			return suf3 ~= "scm" and suf3 ~= "txt" and suf3 ~= "yml" and suf4 ~= "json" and suf4 ~= "yaml"
		end,
	})
	MiniIcons.mock_nvim_web_devicons()
	later(MiniIcons.tweak_lsp_kind)
end)

-- Step one ===================================================================
-- now(function()
-- 	vim.cmd("colorscheme minisummer")
-- end)

-- Step two ===================================================================
-- Mini.extra
later(function()
	require("mini.extra").setup()
end)

-- Mini.ai
later(function()
	local ai = require("mini.ai")
	ai.setup({
		custom_textobjects = {
			B = MiniExtra.gen_ai_spec.buffer(),
			F = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }),
		},
	})
end)

-- Mini.align
later(function()
	require("mini.align").setup()
end)
-- Mini.animate
-- later(function() require('mini.animate').setup({ scroll = { enable = false } }) end)
-- Mini.bracketed
later(function()
	require("mini.bracketed").setup()
end)
-- Mini.bufremove
later(function()
	require("mini.bufremove").setup()
end)
-- Mini.clue
later(function()
	local miniclue = require("mini.clue")
	miniclue.setup({
		clues = {
			Config.leader_group_clues,
			miniclue.gen_clues.builtin_completion(),
			miniclue.gen_clues.g(),
			miniclue.gen_clues.marks(),
			miniclue.gen_clues.registers(),
			miniclue.gen_clues.windows({ submode_resize = true }),
			miniclue.gen_clues.z(),
		},
		triggers = {
			{ mode = "n", keys = "<Leader>" }, -- Leader triggers
			{ mode = "x", keys = "<Leader>" },
			{ mode = "n", keys = [[\]] }, -- mini.basics
			{ mode = "n", keys = "[" }, -- mini.bracketed
			{ mode = "n", keys = "]" },
			{ mode = "x", keys = "[" },
			{ mode = "x", keys = "]" },
			{ mode = "i", keys = "<C-x>" }, -- Built-in completion
			{ mode = "n", keys = "g" }, -- `g` key
			{ mode = "x", keys = "g" },
			{ mode = "n", keys = "'" }, -- Marks
			{ mode = "n", keys = "`" },
			{ mode = "x", keys = "'" },
			{ mode = "x", keys = "`" },
			{ mode = "n", keys = '"' }, -- Registers
			{ mode = "x", keys = '"' },
			{ mode = "i", keys = "<C-r>" },
			{ mode = "c", keys = "<C-r>" },
			{ mode = "n", keys = "<C-w>" }, -- Window commands
			{ mode = "n", keys = "z" }, -- `z` key
			{ mode = "x", keys = "z" },
		},
		window = {
			config = {
				border = "double",
				width = math.ceil(vim.o.columns * 0.3),
				height = math.ceil(vim.o.lines * 0.4),
			},
		},
	})
end)

-- Don't really need it on daily basis
-- later(function() require('mini.colors').setup() end)
-- Mini.comment
later(function()
	require("mini.comment").setup()
end)
-- Mini.completion
later(function()
	require("mini.completion").setup({
		set_vim_settings = false,
		delay = { completion = 50, info = 200, signature = 200 },
		lsp_completion = {
			source_func = "omnifunc",
			auto_setup = true,
		},
		mappings = {
			force_twostep = "<C-Space>",
			force_fallback = "<A-Space>",
			-- Remove the Tab mappings to avoid conflicts
			select_next_item = "<C-n>",
			select_prev_item = "<C-p>",
		},
		window = {
			info = { border = "double" },
			signature = { border = "double" },
		},
	})
	if vim.fn.has("nvim-0.11") == 1 then
		vim.opt.completeopt:append("fuzzy") -- Use fuzzy matching for built-in completion
	end
end)
-- Mini.cursorword
later(function()
	require("mini.cursorword").setup()
end)
-- Mini.diff
later(function()
	require("mini.diff").setup()
	local rhs = function()
		return MiniDiff.operator("yank") .. "gh"
	end
	vim.keymap.set("n", "ghy", rhs, { expr = true, remap = true, desc = "Copy hunk's reference lines" })
end)
-- Mini.doc
later(function()
	require("mini.doc").setup()
end)
-- Mini.files
later(function()
	require("mini.files").setup({ windows = { preview = true, width_preview = math.ceil(vim.o.columns * 0.4) } })

	local minifiles_augroup = vim.api.nvim_create_augroup("ec-mini-files", {})
	vim.api.nvim_create_autocmd("User", {
		group = minifiles_augroup,
		pattern = "MiniFilesWindowOpen",
		callback = function(args)
			vim.api.nvim_win_set_config(args.data.win_id, { border = "double" })
		end,
	})
	vim.api.nvim_create_autocmd("User", {
		group = minifiles_augroup,
		pattern = "MiniFilesExplorerOpen",
		callback = function()
			MiniFiles.set_bookmark("c", vim.fn.stdpath("config"), { desc = "Config" })
			MiniFiles.set_bookmark(
				"m",
				vim.fn.stdpath("data") .. "/site/pack/deps/start/mini.nvim",
				{ desc = "mini.nvim" }
			)
			MiniFiles.set_bookmark("p", vim.fn.stdpath("data") .. "/site/pack/deps/opt", { desc = "Plugins" })
			MiniFiles.set_bookmark("w", vim.fn.getcwd, { desc = "Working directory" })
		end,
	})
end)
-- Mini.git
later(function()
	require("mini.git").setup()
end)

-- Mini.hipatterns
later(function()
	local hipatterns = require("mini.hipatterns")
	local hi_words = MiniExtra.gen_highlighter.words
	hipatterns.setup({
		highlighters = {
			fixme = hi_words({ "FIXME", "Fixme", "fixme" }, "MiniHipatternsFixme"),
			hack = hi_words({ "HACK", "Hack", "hack" }, "MiniHipatternsHack"),
			todo = hi_words({ "TODO", "Todo", "todo" }, "MiniHipatternsTodo"),
			note = hi_words({ "NOTE", "Note", "note" }, "MiniHipatternsNote"),

			hex_color = hipatterns.gen_highlighter.hex_color(),
		},
	})
end)

-- Mini.indentscope
later(function()
	require("mini.indentscope").setup()
end)

-- Mini.jump
later(function()
	require("mini.jump").setup()
end)

-- Mini.jump2d
later(function()
	local jump2d = require("mini.jump2d")
	jump2d.setup({
		spotter = jump2d.gen_pattern_spotter("[^%s%p]+"),
		view = { dim = true, n_steps_ahead = 2 },
	})
end)

-- MIni.map
later(function()
	local map = require("mini.map")
	local gen_integr = map.gen_integration
	map.setup({
		symbols = { encode = map.gen_encode_symbols.dot("4x2") },
		integrations = { gen_integr.builtin_search(), gen_integr.diff(), gen_integr.diagnostic() },
	})
	vim.keymap.set("n", [[\h]], ":let v:hlsearch = 1 - v:hlsearch<CR>", { desc = "Toggle hlsearch", silent = true })
	for _, key in ipairs({ "n", "N", "*" }) do
		vim.keymap.set("n", key, key .. "zv<Cmd>lua MiniMap.refresh({}, { lines = false, scrollbar = false })<CR>")
	end
end)

-- Mini.misc
later(function()
	require("mini.misc").setup({ make_global = { "put", "put_text", "stat_summary", "bench_time" } })
	MiniMisc.setup_auto_root()
	MiniMisc.setup_termbg_sync()
end)
-- Mini.move
later(function()
	require("mini.move").setup({ options = { reindent_linewise = false } })
end)

later(function()
	local remap = function(mode, lhs_from, lhs_to)
		local keymap = vim.fn.maparg(lhs_from, mode, false, true)
		local rhs = keymap.callback or keymap.rhs
		if rhs == nil then
			error("Could not remap from " .. lhs_from .. " to " .. lhs_to)
		end
		vim.keymap.set(mode, lhs_to, rhs, { desc = keymap.desc })
	end
	remap("n", "gx", "<Leader>ox")
	remap("x", "gx", "<Leader>ox")

	require("mini.operators").setup()
end)

-- Mini.pairs
later(function()
	require("mini.pairs").setup({ modes = { insert = true, command = true, terminal = true } })
	vim.keymap.set("i", "<CR>", "v:lua.Config.cr_action()", { expr = true })
end)

-- Mini.pick
later(function()
	require("mini.pick").setup({ window = { config = { border = "double" } } })
	vim.ui.select = MiniPick.ui_select
	vim.keymap.set("n", ",", [[<Cmd>Pick buf_lines scope='current' preserve_order=true<CR>]], { nowait = true })

	MiniPick.registry.projects = function()
		local cwd = vim.fn.expand("~/repos")
		local choose = function(item)
			vim.schedule(function()
				MiniPick.builtin.files(nil, { source = { cwd = item.path } })
			end)
		end
		return MiniExtra.pickers.explorer({ cwd = cwd }, { source = { choose = choose } })
	end
end)

-- Snippet collection =========================================================
-- Mini.snippets
now(function()
	add("rafamadriz/friendly-snippets")
	vim.cmd([[packadd friendly-snippets]])
	local snippets = require("mini.snippets")
	local tex_patterns = { "/latex/*.json", "/latex.json" }
	local lang_patterns = {
		tex = tex_patterns,
		plaintex = tex_patterns,
		markdown_inline = tex_patterns,
		c = { "/c/*.json", "/c.json" },
		cpp = { "/cpp/*.json" },
		lua = { "/lua/*.json", "/lua.json" },
		python = { "/python/*.json" },
	}
	snippets.setup({
		mappings = {
			stop = "<esc>",
		},
		snippets = {
			snippets.gen_loader.from_lang({ lang_patterns = lang_patterns }),
		},
	})
	snippets.start_lsp_server()
end)

-- Mini.splitjoin
later(function()
	require("mini.splitjoin").setup()
end)

-- Mini.surround
later(function()
	require("mini.surround").setup({ search_method = "cover_or_next" })
	-- Disable `s` shortcut (use `cl` instead) for safer usage of 'mini.surround'
	vim.keymap.set({ "n", "x" }, "s", "<Nop>")
end)

-- Mini.trailspace
later(function()
	require("mini.trailspace").setup()
end)

-- Mini.visits
later(function()
	require("mini.visits").setup()
end)
