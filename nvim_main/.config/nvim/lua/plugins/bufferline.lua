return {
	"akinsho/bufferline.nvim",
	version = "*",
	dependencies = "nvim-tree/nvim-web-devicons",
	config = function()
		vim.opt.termguicolors = true
		require("bufferline").setup()
		vim.keymap.set("n", "<Tab>", ":BufferLineCycleNext<cr>", { desc = "BufferLineCycleNext" })
		vim.keymap.set("n", "<S-Tab>", ":BufferLineCyclePrev<cr>", { desc = "BufferLineCyclePrev" })
	end,
}
