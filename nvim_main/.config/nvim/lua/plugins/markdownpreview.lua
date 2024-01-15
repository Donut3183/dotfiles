return {
	"iamcco/markdown-preview.nvim",
	cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
	build = "cd app && yarn install",
	init = function()
		vim.keymap.set("n", "<leader>ms", "<Plug>MarkdownPreview", { desc = "Start Markdown Preview" })
		vim.keymap.set("n", "<leader>mx", "<Plug>MarkdownPreviewStop", { desc = "Stop Markdown Preview" })
		vim.keymap.set("n", "<leader>mp", "<Plug>MarkdownPreviewToggle", { desc = "Toggle Markdown Preview" })

		vim.g.mkdp_filetypes = { "markdown" }
	end,
	ft = { "markdown" },
}
