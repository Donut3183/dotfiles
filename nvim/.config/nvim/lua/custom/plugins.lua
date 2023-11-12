local overrides = require("custom.configs.overrides")
---@type NvPluginSpec[]
local plugins = {
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		---@type Flash.Config
		opts = {},
  -- stylua: ignore
  keys = {
    { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
    { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
    { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
    { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
    { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },

  },
		ft = { "md" },
	},
	-- {
	-- 	"tbabej/taskwiki",
	-- 	event = "VeryLazy",
	-- },
	-- {
	-- 	"vimwiki/vimwiki",
	-- 	lazy = false,
	-- },
	{
		"jackmort/chatgpt.nvim",
		event = "VeryLazy",
		config = function()
			require("chatgpt").setup(require("custom.configs.chatgpt").chatgpt_settings)
		end,
		dependencies = {
			"MunifTanjim/nui.nvim",
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
		},
	},
	{
		"lambdalisue/suda.vim",
		lazy = false,
	},

	{
		"neovim/nvim-lspconfig",
		dependencies = {},
		config = function()
			require("custom.configs.lspconfig")
		end,
	},
	{
		"iamcco/markdown-preview.nvim",
		config = function()
			vim.fn["mkdp#util#install"]()
		end,
		opts = overrides.markdown,
		lazy = true,
		ft = "md",
	},
	-- override plugin configs
	{
		"williamboman/mason.nvim",
		dependencies = {
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
		},
		config = function()
			-- import mason
			local M = require("custom.configs.mason_lspconfig")

			require("mason").setup(M.mason)
			require("mason-lspconfig").setup(M.mason_lspconfig)
			require("mason-tool-installer").setup(M.mason_tool_installer)
		end,
	},

	{
		"nvim-treesitter/nvim-treesitter",
		opts = overrides.treesitter,
	},

	{
		"nvim-tree/nvim-tree.lua",
		opts = overrides.nvimtree,
	},

	-- Install a plugin
	{
		"max397574/better-escape.nvim",
		event = "InsertEnter",
		config = function()
			require("better_escape").setup()
		end,
	},

	-- To make a plugin not be loaded
	-- {
	--   "NvChad/nvim-colorizer.lua",
	--   enabled = false
	-- },
	{
		"lervag/vimtex",
		config = function()
			require("custom.configs.vimtexrc")
		end,
		ft = "tex",
	},
	{
		"stevearc/conform.nvim",
		lazy = true,
		event = { "BufReadPre", "BufNewFile" }, -- to disable, comment this out
		config = function()
			local M = require("custom.configs.conform")
			require("conform").setup(M.conform)
		end,
	},
	{
		"mfussenegger/nvim-lint",
		lazy = true,
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local lint = require("lint")
			local custom_linters = require("custom.configs.linting")
			lint.linters_by_ft = custom_linters.linters

			local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

			vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
				group = lint_augroup,
				callback = function()
					lint.try_lint()
				end,
			})
		end,
	},
}

return plugins
