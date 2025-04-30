local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later
local now_if_args = vim.fn.argc(-1) > 0 and now or later

-- Tree-sitter (advanced syntax parsing, highlighting, textobjects) ===========
now(function()
	add({
		source = "nvim-treesitter/nvim-treesitter",
		checkout = "master",
		hooks = {
			post_checkout = function()
				vim.cmd("TSUpdate")
			end,
		},
	})
	add("nvim-treesitter/nvim-treesitter-textobjects")

  --stylua: ignore
  local ensure_installed = {
    'bash', 'c', 'cpp', 'json',
    'lua', 'markdown', 'markdown_inline', 'python',
    'toml', 'yaml', 'vim', 'vimdoc',
  }

	require("nvim-treesitter.configs").setup({
		ensure_installed = ensure_installed,
		highlight = { enable = true },
		incremental_selection = { enable = false },
		textobjects = { enable = false },
		indent = { enable = false },
	})
end)

-- Install LSP/formatting/linter executables ==================================
now(function()
	add("williamboman/mason.nvim")
	add("williamboman/mason-lspconfig.nvim")
	local ensure_installed = {
		"clangd",
		"lua_ls",
		"ltex",
		"matlab_ls",
	}
	require("mason").setup()
	require("mason-lspconfig").setup({
		ensure_installed = ensure_installed,
		automatic_installation = true,
	})
end)

-- Formatting =================================================================
later(function()
	add("stevearc/conform.nvim")

	require("conform").setup({
		-- Map of filetype to formatters
		formatters_by_ft = {
			json = { "prettier" },
			lua = { "stylua" },
			python = { "black" },
			c = { "clang-format" },
			tex = { "latexindent" },
			markdown = { "prettier" },
		},
	})
end)

-- Language server configurations =============================================
now(function()
	add("neovim/nvim-lspconfig")

	local custom_on_attach = function(client, buf_id)
		-- Set up 'mini.completion' LSP part of completion
		vim.bo[buf_id].omnifunc = "v:lua.MiniCompletion.completefunc_lsp"
		-- Mappings are created globally with `<Leader>l` prefix (for simplicity)
	end

	-- All language servers are expected to be installed with 'mason.vnim'
	local lspconfig = require("lspconfig")

	-- Python
	lspconfig.pyright.setup({ on_attach = custom_on_attach })

	-- Lua
	lspconfig.lua_ls.setup({
		on_attach = function(client, bufnr)
			custom_on_attach(client, bufnr)

			-- Reduce unnecessarily long list of completion triggers for better
			-- 'mini.completion' experience
			client.server_capabilities.completionProvider.triggerCharacters = { ".", ":" }

			-- Override global "Go to source" mapping with dedicated buffer-local
			local opts = { buffer = bufnr, desc = "Lua source definition" }
			vim.keymap.set("n", "<Leader>ls", Config.luals_unique_definition, opts)
		end,
		settings = {
			Lua = {
				runtime = {
					-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
					version = "LuaJIT",
					-- Setup your lua path
					path = vim.split(package.path, ";"),
				},
				diagnostics = {
					-- Get the language server to recognize common globals
					globals = { "vim", "describe", "it", "before_each", "after_each" },
					disable = { "need-check-nil" },
					-- Don't make workspace diagnostic, as it consumes too much CPU and RAM
					workspaceDelay = -1,
				},
				workspace = {
					-- Don't analyze code from submodules
					ignoreSubmodules = true,
				},
				-- Do not send telemetry data containing a randomized but unique identifier
				telemetry = {
					enable = false,
				},
			},
		},
	})

	-- C/C++
	lspconfig.clangd.setup({ on_attach = custom_on_attach })

	-- Grammar
	lspconfig.harper_ls.setup({ on_attach = custom_on_attach })
end)

-- 1) Clone only
now(function()
	add({ source = "lervag/vimtex", checkout = "master" })
	vim.g.vimtex_complete_enabled = 1
	vim.g.vimtex_view_method = "zathura"
	vim.g.vimtex_view_general_viewer = "zathura"
	vim.g.vimtex_compiler_method = "latexmk"
	vim.g.vimtex_compiler_latexmk = {
		out_dir = "build",
		continuous = 1,
		executable = "latexmk",
		options = {
			"-lualatex",
			"-interaction=nonstopmode",
			"-synctex=1",
			"-shell-escape",
			"-file-line-error",
			"-bibtex",
		},
	}
	vim.g.vimtex_compiler_latexmk_engines = { _ = "-lualatex" }
	vim.g.vimtex_quickfix_enabled = 0
	vim.g.vimtex_quickfix_autoclose_after_keystrokes = 1
end)

now(function()
	add("barreiroleo/ltex_extra.nvim")
	local home = vim.fn.expand("~")
	local lspconfig = require("lspconfig")
	lspconfig.ltex.setup({
		filetypes = { "tex", "markdown", "md", "plaintex", "bib", "latex" },
		on_attach = function(client, bufnr)
			vim.bo[bufnr].omnifunc = "v:lua.MiniCompletion.completefunc_lsp"
			require("ltex_extra").setup({
				load_lang = { "en-US" },
			})
		end,
		handlers = {
			-- swallow all progress notifications
			["$/progress"] = function() end,
		},
		settings = {
			ltex = {
				enabled = { "latex", "tex", "markdown", "md", "bib", "plaintex" },
				language = "en-US",
				motherTongue = "en-US",
				additionalRules = {
					enablePickyRules = true,
					languageModel = { home .. "/.ngrams/" },
				},
				dictionary = {
					["ja-JP"] = {}, -- Empty dictionary to prevent error for Japanese
					["km-KH"] = {}, -- Empty dictionary to prevent error for Khmer
				},
				disabledRules = {
					["ja-JP"] = {},
					["km-KH"] = {},
				},
			},
		},
	})
end)

later(function()
	vim.api.nvim_create_autocmd("FileType", {
		pattern = { "tex", "md", "markdown" },
		callback = function()
			vim.cmd("packadd ltex_extra")
			vim.cmd("packadd vimtex")
			vim.opt_local.completefunc = "vimtex#complete#omnifunc"
		end,
	})
end)

-- Better built-in terminal ===================================================
later(function()
	add("kassio/neoterm")

	-- Enable bracketed paste
	vim.g.neoterm_bracketed_paste = 1

	-- Default python REPL
	vim.g.neoterm_repl_python = "ipython"

	-- Default R REPL
	vim.g.neoterm_repl_r = "radian"

	-- Don't add extra call to REPL when sending
	vim.g.neoterm_direct_open_repl = 1

	-- Open terminal to the right by default
	vim.g.neoterm_default_mod = "vertical"

	-- Go into insert mode when terminal is opened
	vim.g.neoterm_autoinsert = 1

	-- Scroll to recent command when it is executed
	vim.g.neoterm_autoscroll = 1

	-- Don't automap keys
	pcall(vim.keymap.del, "n", ",tt")

	-- Change default shell to zsh (if it is installed)
	if vim.fn.executable("zsh") == 1 then
		vim.g.neoterm_shell = "zsh"
	end
end)

-- Documentation generator ====================================================
later(function()
	add("danymat/neogen")
	require("neogen").setup({
		snippet_engine = "mini",
		languages = {
			lua = { template = { annotation_convention = "emmylua" } },
			python = { template = { annotation_convention = "numpydoc" } },
		},
	})
end)

-- Filetype: markdown =========================================================
later(function()
	local build = function()
		vim.fn["mkdp#util#install"]()
	end
	add({
		source = "iamcco/markdown-preview.nvim",
		hooks = {
			post_install = function()
				later(build)
			end,
			post_checkout = build,
		},
	})

	-- Do not close the preview tab when switching to other buffers
	vim.g.mkdp_auto_close = 0
end)

-- Filetype: rmarkdown ========================================================
later(function()
	-- This option should be set before loading plugin to take effect. See
	-- https://github.com/vim-pandoc/vim-pandoc/issues/342
	vim.g["pandoc#filetypes#pandoc_markdown"] = 0

	add({
		source = "vim-pandoc/vim-rmarkdown",
		depends = { "vim-pandoc/vim-pandoc", "vim-pandoc/vim-pandoc-syntax" },
	})

	-- Show raw symbols
	vim.g["pandoc#syntax#conceal#use"] = 0

	-- Folding
	vim.g["pandoc#folding#fold_yaml"] = 1
	vim.g["pandoc#folding#fold_fenced_codeblocks"] = 1
	vim.g["pandoc#folding#fastfolds"] = 1
	vim.g["pandoc#folding#fdc"] = 0
end)

-- Todo-comments.nvim **********************************************************
later(function()
	add({
		source = "folke/todo-comments.nvim",
		depends = { "nvim-lua/plenary.nvim" },
	})
	require("todo-comments").setup()
end)

-- ChatGPT plugin =============================================================
now(function()
	add({
		source = "Donut3183/ChatGPT.nvim",
		depends = {
			"MunifTanjim/nui.nvim",
			"nvim-lua/plenary.nvim",
			"folke/trouble.nvim", -- optional
			"nvim-telescope/telescope.nvim",
			"echasnovski/mini.icons",
		},
	})
	local home = vim.fn.expand("~")
	local vim_path = vim.fn.stdpath("config")
	require("chatgpt").setup({
		api_key_cmd = "gpg --decrypt " .. home .. "/Documents/openai_api_key.txt.gpg",
		actions_paths = { vim_path .. "/misc/configs/actions.json" },
		openai_params = {
			model = "gpt-4-1106-preview",
			frequency_penalty = 0,
			presence_penalty = 0,
			max_tokens = 4095,
			temperature = 0.2,
			top_p = 0.1,
			n = 1,
		},
	})
end)

now(function()
	add({
		source = "rickhowe/diffchar.vim",
	})
	-- vim.g.DiffUnit = "Word1" -- Enable word-level diff highlighting
	vim.g.DiffColors = 0
end)

-- -- Popular color schemes for testing ==========================================
later(function()
	add("folke/tokyonight.nvim")
	add({ source = "catppuccin/nvim", name = "catppuccin-nvim" })
	add("ellisonleao/gruvbox.nvim")
	add("rebelot/kanagawa.nvim")
	add("sainnhe/everforest")
	add({ source = "rose-pine/neovim", name = "rose-pine" })
	add("bluz71/vim-moonfly-colors")
	add("ellisonleao/gruvbox.nvim")
	add("craftzdog/solarized-osaka.nvim")
	add("navarasu/onedark.nvim")
	add("projekt0n/github-nvim-theme")
	add("marko-cerovac/material.nvim")
	require("material").setup({ plugins = { "mini" } })
	add("EdenEast/nightfox.nvim")
	add("scottmckendry/cyberdream.nvim")
	add("Shatur/neovim-ayu")
	vim.cmd("colorscheme ayu-mirage")
end)
