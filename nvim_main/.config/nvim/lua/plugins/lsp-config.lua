-- Define a common on_attach function to be used for C, Python, and Lua
local function on_attach(client, bufnr)
	-- Add your buffer-local key mappings, commands, etc. here
	-- Example of setting up buffer-local key mappings:
	-- local bufopts = { noremap = true, silent = true, buffer = bufnr }
	-- vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
	-- vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
	-- ... more key mappings ...

	-- lsp_signature configuration
	local cfg = {
		bind = true,
		handler_opts = {
			border = "rounded",
		},
		-- Add other lsp_signature configurations here
	}
	require("lsp_signature").on_attach(cfg, bufnr)
end

return {
	{
		"p00f/clangd_extensions.nvim",
		dependencies = { "neovim/nvim-lspconfig" },
	},
	{
		"barreiroleo/ltex-extra.nvim",
		ft = { "markdown", "tex" },
		dependencies = { "neovim/nvim-lspconfig" },
		config = function()
			require("ltex_extra").setup({
				-- Add your ltex_extra options here
				-- Example: additional_vim_regex_highlighting = true,
				server_opts = {
					-- Replace `your_capabilities` with your actual capabilities setup
					capabilities = require("cmp_nvim_lsp").default_capabilities(
						vim.lsp.protocol.make_client_capabilities()
					),

					on_attach = on_attach,
					settings = {
						ltex = {
							-- Replace this with your actual ltex settings
							-- Example: language = "en",
						},
					},
				},
			})
		end,
	},
	-- {
	-- 	"brymer-meneses/grammar-guard.nvim",
	-- 	dependencies = {
	-- 		"neovim/nvim-lspconfig",
	-- 		"williamboman/nvim-lsp-installer",
	-- 	},
	-- },
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"arduino_language_server",
					"bashls",
					"clangd",
					"cmake",
					"jsonls",
					-- "ltex",
					"remark_ls",
					"matlab_ls",
					"pyright",
					"taplo",
					-- "lemminx",
					"hydra_lsp",
				},
			})

			require("mason-lspconfig").setup_handlers({
				function(server)
					local lspconfig = require("lspconfig")
					local capabilities = require("cmp_nvim_lsp").default_capabilities()
					lspconfig[server].setup({
						capabilities = capabilities,
						on_attach = on_attach,
					})
				end,
			})
			require("lspconfig").matlab_ls.setup({
				on_attach = on_attach,
				cmd = { "/home/pontus/.local/share/nvim/mason/bin/matlab-language-server", "--stdio" },
				filetypes = { "matlab" },
				single_file_support = true,
				settings = {
					matlab = {
						indexWorkspace = false,
						installPath = "/opt/matlab/R2023b/",
						matlabConnectionTiming = "onStart",
						telemetry = true,
					},
				},
			})
			-- require("lspconfig").ltex.setup({
			-- 	on_attach = on_attach,
			-- 	ltex = {
			-- 		language = "en-US",
			-- 	},
			-- })
			-- setup clangd again just because
			require("lspconfig").clangd.setup({
				on_attach = on_attach,
				cmd = {
					"clangd",
				},
			})
			require("lspconfig").pyright.setup({
				on_attach = on_attach,
			})
			-- require("lspconfig").grammar_guard.setup({
			-- 	cmd = { "/usr/bin/ltex-ls" },
			-- 	settings = {
			-- 		ltex = {
			-- 			enabled = { "latex", "tex", "bib" },
			-- 			language = "en",
			-- 			diagnosticSeverity = "information",
			-- 			setenceCacheSize = 2000,
			-- 			additionalRules = {
			-- 				enablePickyRules = false,
			-- 				motherTongue = "se",
			-- 			},
			-- 			trace = { server = "verbose" },
			-- 			dictionary = {},
			-- 			disabledRules = {},
			-- 			hiddenFalsePositives = {},
			-- 		},
			-- 	},
			-- })
		end,
	},
	{
		"neovim/nvim-lspconfig",

		config = function()
			-- require("grammar-guard").init()
			require("clangd_extensions.inlay_hints").setup_autocmd()
			require("clangd_extensions.inlay_hints").set_inlay_hints()
			-- setup LSP config
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspConfig", {}),
				callback = function(ev)
					-- Enable completion triggered by <c-x><c-o>
					vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

					-- Buffer local mappings.
					-- See `:help vim.lsp.*` for documentation on any of the below functions
					vim.keymap.set(
						"n",
						"<leader>gD",
						vim.lsp.buf.declaration,
						{ desc = "Declaration", buffer = ev.buf }
					)
					vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Definition", buffer = ev.buf })
					vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover", buffer = ev.buf })
					vim.keymap.set(
						"n",
						"<leader>gi",
						vim.lsp.buf.implementation,
						{ desc = "Implementation", buffer = ev.buf }
					)
					vim.keymap.set(
						"n",
						"<leader>gk",
						vim.lsp.buf.signature_help,
						{ desc = "signature", buffer = ev.buf }
					)
					vim.keymap.set(
						"n",
						"<leader>gw",
						vim.lsp.buf.add_workspace_folder,
						{ desc = "add workspace folder", buffer = ev.buf }
					)
					vim.keymap.set(
						"n",
						"<leader>gr",
						vim.lsp.buf.remove_workspace_folder,
						{ desc = "remove workspace folder", buffer = ev.buf }
					)
					vim.keymap.set("n", "<leader>gL", function()
						print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
					end, { desc = "list workspace folders", buffer = ev.buf })
					vim.keymap.set(
						"n",
						"<leader>gT",
						vim.lsp.buf.type_definition,
						{ desc = "type definition", buffer = ev.buf }
					)
					-- vim.keymap.set("n", "<leader>gr", vim.lsp.buf.rename, { desc = "rename buffer", buffer = ev.buf })
					vim.keymap.set(
						{ "n", "v" },
						"<leader>ca",
						vim.lsp.buf.code_action,
						{ desc = "code action", buffer = ev.buf }
					)
					-- vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, { desc = "references", buffer = ev.buf })

					vim.keymap.set("n", "<leader>gW", function()
						vim.diagnostic.setloclist()
					end, { desc = "warning list", buffer = ev.buf })
					vim.keymap.set("n", "<leader>xe", function()
						vim.diagnostic.open_float()
					end, { desc = "show warnings", buffer = ev.buf })

					-- Lua
					vim.keymap.set("n", "<leader>gx", function()
						require("trouble").toggle()
					end, { desc = "Toggle trouble", buffer = ev.buf })

					vim.keymap.set("n", "<leader>ge", function()
						require("trouble").toggle("workspace_diagnostics")
					end, { desc = "workspace diagnostics", buffer = ev.buf })

					vim.keymap.set("n", "<leader>ga", function()
						require("trouble").toggle("document_diagnostics")
					end, { desc = "document diagnostics", buffer = ev.buf })

					vim.keymap.set("n", "<leader>gq", function()
						require("trouble").toggle("quickfix")
					end, { desc = "quickfix", buffer = ev.buf })

					vim.keymap.set("n", "<leader>gl", function()
						require("trouble").toggle("loclist")
					end, { desc = "loclist", buffer = ev.buf })

					vim.keymap.set("n", "gR", function()
						require("trouble").toggle("lsp_references")
					end, { desc = "lsp references", buffer = ev.buf })
				end,
			})
		end,
	},
}
