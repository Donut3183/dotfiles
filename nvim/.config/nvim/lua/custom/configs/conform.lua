local M = {}

M.conform = {
	formatters_by_ft = {
		c = { "clang_format" },
		lua = { "stylua" },
		python = { "isort", "black" },
		sh = { "shfmt" },
		json = { "jq" },
		xml = { "xmlformat" },
		yaml = { "prettier" },
		jsonc = { "prettier" },
		ctl = { "prettier" },
		css = { "prettier" },
		["*"] = { "codespell" },
		["_"] = { "trim_whitespace", "trim_newlines" },
	},

	format_on_save = {
		lsp_fallback = true,
		async = false,
		timeout_ms = 500,
	},
}
M.conform_format_settings = {
	format_on_save = {
		lsp_fallback = true,
		async = false,
		timeout_ms = 500,
	},
}

return M
