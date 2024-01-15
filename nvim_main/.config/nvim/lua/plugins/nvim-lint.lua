return {
	"mfussenegger/nvim-lint",
	lazy = false,
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local lint = require("lint")
		lint.linters_by_ft = {
			python = { "pylint" },
			c = { "clangtidy" },
			matlab = { "mlint" },
			bash = { "shellcheck" },
			latex = { "chktex" },
			-- test = { "vale" },
			-- xml = { "tidy" },
			-- markdown = { "markdownlint" },
			-- lua = { "selene" },
			cmake = { "cmakelint" },
		}

		local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

		vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
			group = lint_augroup,
			callback = function()
				require("lint").try_lint()
			end,
		})
	end,
}
