-- ~/.config/nvim/plugin/0_options.lua
local o = vim.opt
-- Leader key =================================================================
vim.g.mapleader = " "

-- General ====================================================================
o.backup = false -- Don't store backup
o.mouse = "a" -- Enable mouse
o.clipboard = "unnamedplus"
-- o.mousescroll  = 'ver:25,hor:6' -- Customize mouse scroll
o.switchbuf = "usetab" -- Use already opened buffers when switching
o.writebackup = false -- Don't store backup (better performance)
o.undofile = true -- Enable persistent undo

o.shada = "'100,<50,s10,:1000,/100,@100,h" -- Limit what is stored in ShaDa file

vim.cmd("filetype plugin indent on") -- Enable all filetype plugins

-- UI =========================================================================
o.breakindent = true -- Indent wrapped lines to match line start
o.colorcolumn = "+1" -- Draw colored column one step to the right of desired maximum width
o.cursorline = true -- Enable highlighting of the current line
o.linebreak = true -- Wrap long lines at 'breakat' (if 'wrap' is set)
o.list = true -- Show helpful character indicators
o.number = true -- Show line numbers
o.relativenumber = true
o.pumheight = 10 -- Make popup menu smaller
o.ruler = false -- Don't show cursor position
o.shortmess = "FOSWaco" -- Disable certain messages from |ins-completion-menu|
o.showmode = false -- Don't show mode in command line
o.signcolumn = "yes" -- Always show signcolumn or it would frequently shift
o.splitbelow = true -- Horizontal splits will be below
o.splitright = true -- Vertical splits will be to the right
o.wrap = true -- Display long lines as just one line

o.fillchars = table.concat(
	-- Special UI symbols
	{
		"eob: ",
		"fold:╌",
		"horiz:═",
		"horizdown:╦",
		"horizup:╩",
		"vert:║",
		"verthoriz:╬",
		"vertleft:╣",
		"vertright:╠",
	},
	","
)
o.listchars = table.concat({ "extends:…", "nbsp:␣", "precedes:…", "tab:> " }, ",") -- Special text symbols
o.cursorlineopt = "screenline,number" -- Show cursor line only screen line when wrapped
o.breakindentopt = "list:-1" -- Add padding for lists when 'wrap' is on

if vim.fn.has("nvim-0.9") == 1 then
	o.shortmess = "CFOSWaco" -- Don't show "Scanning..." messages
	o.splitkeep = "screen" -- Reduce scroll during window split
end

if vim.fn.has("nvim-0.10") == 0 then
	o.termguicolors = true -- Enable gui colors (Neovim>=0.10 does this automatically)
end

-- Colors =====================================================================
-- Enable syntax highlighing if it wasn't already (as it is time consuming)
-- Don't use defer it because it affects start screen appearance
if vim.fn.exists("syntax_on") ~= 1 then
	vim.cmd("syntax enable")
end

-- Editing ====================================================================
o.autoindent = true -- Use auto indent
o.expandtab = true -- Convert tabs to spaces
o.formatoptions = "rqnl1j" -- Improve comment editing
o.ignorecase = true -- Ignore case when searching (use `\C` to force not doing that)
o.incsearch = true -- Show search results while typing
o.infercase = true -- Infer letter cases for a richer built-in keyword completion
o.shiftwidth = 4 -- Use this number of spaces for indentation
o.smartcase = true -- Don't ignore case when searching if pattern has upper case
o.smartindent = true -- Make indenting smart
o.tabstop = 4 -- Insert 2 spaces for a tab
o.softtabstop = 4 -- Insert 2 spaces for a tab
o.virtualedit = "block" -- Allow going past the end of line in visual block mode

o.iskeyword = "@,48-57,_,192-255,-" -- Treat dash separated words as a word text object

-- Define pattern for a start of 'numbered' list. This is responsible for
-- correct formatting of lists when using `gw`. This basically reads as 'at
-- least one special character (digit, -, +, *) possibly followed some
-- punctuation (. or `)`) followed by at least one space is a start of list
-- item'
o.formatlistpat = [[^\s*[0-9\-\+\*]\+[\.\)]*\s\+]]

o.completeopt = "menuone,noselect" -- Show popup even with one item and don't autoselect first
if vim.fn.has("nvim-0.11") == 1 then
	o.completeopt = "menuone,noselect,fuzzy" -- Use fuzzy matching for built-in completion
end

-- Spelling ===================================================================
o.spelllang = "en" -- Define spelling dictionaries
o.spelloptions = "camel" -- Treat parts of camelCase words as seprate words
-- o.complete = ".,w,b,u,kspell" -- Use spell check and don't use tags for completion

o.dictionary = vim.fn.stdpath("config") .. "/misc/dict/english.txt" -- Use specific dictionaries

-- Folds ======================================================================
o.foldmethod = "indent" -- Set 'indent' folding method
o.foldlevel = 1 -- Display all folds except top ones
o.foldnestmax = 10 -- Create folds only for some number of nested levels
vim.g.markdown_folding = 1 -- Use folding by heading in markdown files

if vim.fn.has("nvim-0.10") == 1 then
	o.foldtext = "" -- Use underlying text with its highlighting
end

-- Custom autocommands ========================================================
local augroup = vim.api.nvim_create_augroup("CustomSettings", {})
vim.api.nvim_create_autocmd("FileType", {
	group = augroup,
	callback = function()
		-- Don't auto-wrap comments and don't insert comment leader after hitting 'o'
		-- If don't do this on `FileType`, this keeps reappearing due to being set in
		-- filetype plugins.
		vim.cmd("setlocal formatoptions-=c formatoptions-=o")
	end,
	desc = [[Ensure proper 'formatoptions']],
})

-- Diagnostics ================================================================
local diagnostic_opts = {
	float = { border = "double" },
	-- Show gutter sings
	signs = {
		-- With highest priority
		priority = 9999,
		-- Only for warnings and errors
		severity = { min = "WARN", max = "ERROR" },
	},
	-- Show virtual text only for errors
	virtual_text = { severity = { min = "ERROR", max = "ERROR" } },
	-- Don't update diagnostics when typing
	update_in_insert = false,
}

vim.diagnostic.config(diagnostic_opts)
--stylua: ignore end
