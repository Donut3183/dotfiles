---@type MappingsTable
local M = {}

M.general = {
	n = {
		[";"] = { ":", "enter command mode", opts = { nowait = true } },
		-- ["<C-b>"] = { "mpea**<Esc>bi**<Esc>`p<CR>", "Toggle markdown Bold" },
	},
}
M.markdownpreview = {
	n = {
		["<leader>mp"] = { ":MarkdownPreviewToggle<CR>", "Toggle Markdown Preview" },
	},
}

-- more keybinds!

return M
