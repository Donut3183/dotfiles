return {
	"lervag/vimtex",
	dependencies = {
		"brymer-meneses/grammar-guard.nvim",
	},
	config = function()
		-- vim.g.vimtex_view_method = ""
		vim.g.vimtex_view_general = "okular"
		vim.g.vimtex_compiler_method = "latexmk"
		-- vim.g.vimtex_compiler_method = "latexrun"
		vim.g.maplocalleader = " "
		vim.g.vimtex_quickfix_enabled = 1
		vim.g.vimtex_quickfix_autoclose_after_keystrokes = 1
	end,
	ft = "tex",
}
