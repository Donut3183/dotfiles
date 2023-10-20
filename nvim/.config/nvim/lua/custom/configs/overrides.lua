local M = {}

M.markdownpreview = { -- Place your markdown-preview.nvim settings here
	auto_start = 1,
	auto_close = 0,
	refresh_slow = 0,
	command_for_global = 0,
	open_to_the_world = 0,
	open_ip = "",
	browser = "",
	echo_preview_url = 0,
	browserfunc = "",
	preview_options = {
		mkit = {},
		katex = {},
		uml = {},
		maid = {},
		disable_sync_scroll = 0,
		sync_scroll_type = "middle",
		hide_yaml_meta = 1,
		sequence_diagrams = {},
		flowchart_diagrams = {},
		content_editable = false,
		disable_filename = 0,
		toc = {},
	},
	markdown_css = "",
	highlight_css = "",
	port = "",
	page_title = "「${name}」",
	filetypes = { "markdown" },
	theme = "dark",
}
M.treesitter = {
	ensure_installed = {
		"vim",
		"lua",
		"html",
		"css",
		"javascript",
		"typescript",
		"tsx",
		"c",
		"markdown",
		"markdown_inline",
	},
	indent = {
		enable = true,
		-- disable = {
		--   "python"
		-- },
	},
}

M.mason = {
	ensure_installed = {
		-- lua stuff
		"lua-language-server",
		"stylua",

		-- web dev stuff
		"css-lsp",
		"html-lsp",
		"typescript-language-server",
		"deno",
		"prettier",

		-- c/cpp stuff
		"clangd",
		"clang-format",
		-- Latex stuff
		"ltex-ls",
	},
}

-- git support in nvimtree
M.nvimtree = {
	git = {
		enable = true,
	},
	view = {
		adaptive_size = false,
		side = "left",
		width = 40,
		-- hide_root_folder = false,
		preserve_window_proportions = true,
	},
	renderer = {
		highlight_git = true,
		icons = {
			show = {
				git = true,
			},
		},
	},
}

return M
