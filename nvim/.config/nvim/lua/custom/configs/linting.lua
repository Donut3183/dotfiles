local M = {}

M.linters = {
	linters_by_ft = {
		python = { "pyflakes" },
		c = { "cpplint" },
		bash = { "shellcheck" },
		latex = { "vale" },
		test = { "vale" },
		lua = { "selene" },
	},
}
return M
