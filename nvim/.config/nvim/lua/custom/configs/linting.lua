local M = {}

M.linters = {
	linters_by_ft = {
		python = { "pylint" },
		c = { "cpplint" },
		matlab = { "mlint" },
		bash = { "shellcheck" },
		latex = { "chktex" },
		test = { "vale" },
		xml = { "vale" },
		markdown = { "vale" },
		lua = { "selene" },
		cmake = { "cmakelint" },
	},
}
return M
