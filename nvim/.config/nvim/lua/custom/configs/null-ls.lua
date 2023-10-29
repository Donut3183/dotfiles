local present, null_ls = pcall(require, "null-ls")

if not present then
	return
end

local b = null_ls.builtins
local c = null_ls.builtins.code_actions

local sources = {

	-- webdev stuff
	b.formatting.deno_fmt, -- choosed deno for ts/js files cuz its very fast!
	b.formatting.prettier.with({ filetypes = { "html", "markdown", "css", "conf" } }), -- so prettier works only on these filetypes

	-- Lua
	b.formatting.stylua,

	-- Sh
	b.formatting.beautysh,
	c.shellcheck,
	-- git
	c.gitsigns,

	-- cpp
	b.formatting.clang_format,

	-- Latex
	b.formatting.latexindent.with({ filetypes = { "tex" }, command = "latexindent", formatOnSave = true }),

	--python
	b.formatting.autopep8.with({ filetypes = { "python" }, formatOnSave = true }),
}

null_ls.setup({
	debug = true,
	sources = sources,
})
