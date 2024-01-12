return {
	"voldikss/vim-floaterm",
	config = function()
		vim.keymap.set("n", "<A-i>", ":FloatermToggle<CR>", { silent = true, desc = "Toggle floating terminal" })
		vim.keymap.set(
			"t",
			"<A-i>",
			"<C-\\><C-n>:FloatermToggle<CR>",
			{ silent = true, desc = "Toggle floating terminal from terminal mode" }
		)
	end,
}
