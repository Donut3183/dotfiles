return {
	"folke/which-key.nvim",
	commit = "e271c28", -- groups naming breaks
	config = function()
		local wk = require("which-key")
		vim.o.timeout = true
		vim.o.timeoutlen = 100
		wk.register({
			["<leader>"] = {
				b = { name = "+Buffer" },
				g = { name = "+LSP stuff" },
				c = { name = "+Code" },
				f = { name = "+Find files" },
			},
		})
		wk.setup()
	end,
}
