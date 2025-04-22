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
    'bash', 'c',        'cpp',             'json',
    'lua',  'markdown', 'markdown_inline', 'python',
    'toml', 'yaml',     'vim',             'vimdoc',
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

	-- LaTex plus
	lspconfig.ltex_plus.setup({
		on_attach = custom_on_attach,
		handlers = {
			-- swallow all progress notifications
			["$/progress"] = function() end,
		},
		settings = {
			ltex = {
				enabled = true,
				language = "en-US",
				additionalRules = {
					enablePickyRules = true,
					languageModel = "~/.ngrams/",
				},
			},
		},
	})
end)

-- 1) Clone only
now(function()
	add("lervag/vimtex")

	-- Zathura viewer (full integration via xdotool+libsynctex)
	vim.g.vimtex_view_method = "zathura"
	-- vim.g.vimtex_view_zathura_options = "--unique file:@pdf#src:@line@tex"
	-- vim.g.vimtex_view_zathura_check_libsynctex = 1

	-- Compiler settings
	vim.g.vimtex_compiler_method = "latexmk"
	vim.g.vimtex_compiler_latexmk = {
		build_dir = "", -- change if you want an out‑dir
		options = {
			"-lualatex",
			"-interaction=nonstopmode",
			"-synctex=1",
			"-shell-escape",
		},
	}
	vim.g.vimtex_compiler_latexmk_engines = { _ = "-lualatex" }

	vim.g.vimtex_quickfix_enabled = 0
	vim.g.vimtex_quickfix_autoclose_after_keystrokes = 1
end)

later(function()
	vim.api.nvim_create_autocmd("FileType", {
		pattern = "tex",
		callback = function()
			vim.cmd("packadd vimtex")
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
	local home = vim.fn.expand("$HOME")
	require("chatgpt").setup({
		-- this config assumes you have OPENAI_API_KEY environment variable set
		api_key_cmd = "gpg --decrypt " .. home .. "/Documents/openai_api_key.txt.gpg",
		actions_paths = {
			"~/.config/nvim/misc/configs/actions.json",
		},
		openai_params = {
			-- NOTE: model can be a function returning the model name
			-- this is useful if you want to change the model on the fly
			-- using commands
			-- Example:
			-- model = function()
			--     if some_condition() then
			--         return "gpt-4-1106-preview"
			--     else
			--         return "gpt-3.5-turbo"
			--     end
			-- end,
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
	vim.g.DiffUnit = "Word1" -- Enable word-level diff highlighting
end)

-- Augment ====================================================================
now(function()
	vim.g.augment_disable_tab_mapping = true
	add({
		source = "augmentcode/augment.vim",
	})

	local home = os.getenv("HOME")

	-- Define your workspace folders here
	workspace_folders = {
		home .. "/DVA218/RTP",
		home .. "/.config/nvim",
		home .. "/dotfiles/nvim/.config/nvim",
	}

	-- Set the global variable used by augment.vim
	vim.g.augment_workspace_folders = workspace_folders

	vim.api.nvim_create_autocmd("User", {
		pattern = "AugmentLoaded", -- hypothetical event; check if Augment emits one
		callback = function()
			vim.keymap.set("i", "<Tab>", [[pumvisible() ? "\<C-n>" : "\<Tab>"]], { expr = true })
			vim.keymap.set("i", "<S-Tab>", [[pumvisible() ? "\<C-p>" : "\<S-Tab>"]], { expr = true })
		end,
	})
end)
-- -- Popular color schemes for testing ==========================================
-- later(function()
--   add('folke/tokyonight.nvim')
--   add({ source = 'catppuccin/nvim', name = 'catppuccin-nvim' })
--   add('rebelot/kanagawa.nvim')
--   add('sainnhe/everforest')
--   add({ source = 'rose-pine/neovim', name = 'rose-pine' })
--   add('bluz71/vim-moonfly-colors')
--   add('ellisonleao/gruvbox.nvim')
--   add('craftzdog/solarized-osaka.nvim')
--   add('navarasu/onedark.nvim')
--   add('projekt0n/github-nvim-theme')
--   add('marko-cerovac/material.nvim')
--   require('material').setup({ plugins = { 'mini' } })
--   add('EdenEast/nightfox.nvim')
--   add('scottmckendry/cyberdream.nvim')
--   add('Shatur/neovim-ayu')
-- end)
