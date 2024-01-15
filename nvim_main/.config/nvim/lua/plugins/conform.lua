return {
	"stevearc/conform.nvim",
	config = function()
		require("conform").setup({
			formatters_by_ft = {

				lua = { "stylua" },
				-- Conform will run multiple formatters sequentially
				python = { "isort", "black" },
				-- Use a sub-list to run only the first available formatter
				javascript = { { "prettierd", "prettier" } },
				c = { "clang_format" },
				cpp = { "clang_format" },
				tex = { "latexindent" },
				xml = { "xmllint" },
				toml = { "taplo" },
				sh = { "shfmt" },

				-- Use the "*" filetype to run formatters on all filetypes.
				-- ["*"] = { "codespell" },
				-- Use the "_" filetype to run formatters on filetypes that don't
				-- have other formatters configured.
				["_"] = { "trim_whitespace" },
			},
			format_on_save = {
				-- These options will be passed to conform.format()
				timeout_ms = 500,
				lsp_fallback = true,
			},
			vim.keymap.set("n", "<leader>fm", function()
				require("conform").format({})
				-- vim.lsp.buf.format({ async = true })
			end, { desc = "format" }),
		})
	end,
}
