local M = {}

local home = os.getenv "HOME"

-- Define your workspace folders here
M.workspace_folders = {
  -- home .. "/lab3b",
  home .. "/DVA218/RTP",
  home .. ".config/nvim",
  -- Add more if needed
}

-- Set the global variable used by augment.vim
vim.g.augment_workspace_folders = M.workspace_folders

-- Returns true if current working dir is inside a known workspace folder
function M.in_workspace()
  local cwd = vim.fn.getcwd()
  for _, folder in ipairs(M.workspace_folders) do
    if cwd:sub(1, #folder) == folder then
      return true
    end
  end
  return false
end

return M
