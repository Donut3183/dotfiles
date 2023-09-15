---@type MappingsTable
local M = {}

M.general = {
	n = {
		[";"] = { ":", "enter command mode", opts = { nowait = true } },
	},
}
M.markdownpreview = {
	n = {
		["<leader>mp"] = { ":MarkdownPreviewToggle<CR>", "Toggle Markdown Preview" },
	},
}

-- more keybinds!

return M
