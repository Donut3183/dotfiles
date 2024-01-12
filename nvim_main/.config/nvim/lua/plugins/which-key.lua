return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	config = function()
		local wk = require("which-key")
		vim.o.timeout = true
		vim.o.timeoutlen = 100
		wk.register({
			["<leader>"] = {
				g = { name = "+LSP" },
				b = { name = "+Buffer" },
			},
		})
	end,
}
