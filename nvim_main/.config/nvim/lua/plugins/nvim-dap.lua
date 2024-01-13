return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"nvim-telescope/telescope-dap.nvim",
	},
	config = function()
		require("dapui").setup()
		vim.keymap.set(
			"n",
			"<leader>db",
			"<cmd>lua require'dap'.toggle_breakpoint()<CR>",
			{ desc = "Toggle DAP breakpoint" }
		)
		vim.keymap.set("n", "<leader>dc", "<cmd>lua require'dap'.continue()<CR>", { desc = "Continue DAP session" })
		vim.keymap.set("n", "<leader>do", "<cmd>lua require'dap'.step_over()<CR>", { desc = "DAP step over" })
		vim.keymap.set("n", "<leader>di", "<cmd>lua require'dap'.step_into()<CR>", { desc = "DAP step into" })
		vim.keymap.set("n", "<leader>dr", "<cmd>lua require'dap'.repl.open()<CR>", { desc = "Open DAP REPL" })
		vim.keymap.set("n", "<leader>dw", "<cmd>DapWidgets<CR>", { desc = "Open DAP Widgets UI" })
		vim.keymap.set("n", "<leader>duo", "<cmd>lua require('dapui').open()<CR>", { desc = "Open DAP UI" })
		vim.keymap.set("n", "<leader>duc", "<cmd>lua require('dapui').close()<CR>", { desc = "Close DAP UI" })
		vim.keymap.set("n", "<leader>dut", "<cmd>lua require('dapui').toggle()<CR>", { desc = "Toggle DAP UI" })
	end,
}
