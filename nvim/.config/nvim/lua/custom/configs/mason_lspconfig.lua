local M = {}
M.mason = {
	ui = {
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗",
		},
	},
}
M.mason_lspconfig = {
	ensure_installed = {
		"lua_ls",
		"clangd",
		"pyright",
		"arduino_language_server",
		"bashls",
		"cmake",
		"jsonls",
		"ltex",
		"matlab_ls",
		"marksman",
		"taplo",
		"lemminx",
		"hydra_lsp",
	},
}
M.mason_tool_installer = {
	ensure_installed = {
		"prettier",
		"stylua",
		"pylint",
		"lua-language-server",
		"shellcheck",
		"shfmt",
	},
}
return M
