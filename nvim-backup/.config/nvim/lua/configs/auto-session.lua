local M = {}

function M.setup()
  -- Set sessionoptions before plugin loads (critical for proper session handling)
  vim.opt.sessionoptions = "blank,buffers,folds,help,localoptions,tabpages,winsize,terminal"

  return {
    autoshow_picker = false, -- Enable automatic session picker on startup
    keys = {
      { "<leader>ww", "<cmd>SessionSearch<CR>", desc = "Search sessions" },
      { "<leader>ws", "<cmd>SessionSave<CR>", desc = "Save current session" },
      { "<leader>wd", "<cmd>SessionDelete<CR>", desc = "Delete session" },
      { "<leader>wa", "<cmd>SessionToggleAutoSave<CR>", desc = "Toggle auto-save" },
    },
    opts = {
      bypass_session_save_file_types = { "alpha" }, -- Don't save sessions for these filetypes
      session_lens = {
        load_on_setup = true,
        previewer = true,
        theme_conf = {
          border = true,
          width = 0.8, -- 80% of window width
          height = 0.7, -- 70% of window height
        },
        mappings = {
          delete_session = { "n", "d" }, -- Normal mode mapping
          open_session = { "n", "<CR>" }, -- Enter to open
          alternate_session = { "n", "a" }, -- Alternate selection
          copy_session = { "n", "yy" }, -- Yank session name
        },
      },
    },
  }
end

local function change_nvim_tree_dir()
  local nvim_tree = require "nvim-tree"
  nvim_tree.change_dir(vim.fn.getcwd())
end

function M.init_plugin()
  local config = M.setup()

  -- Safely initialize auto-session with error handling
  local ok, auto_session = pcall(require, "auto-session")
  if not ok then
    vim.notify("auto-session not available", vim.log.levels.ERROR)
    return
  end

  auto_session.setup(vim.tbl_deep_extend("force", {
    log_level = "info",
    auto_save = { enabled = true },
    auto_restore = { enabled = false },
    cwd_change_handling = {
      restore_upcoming_session = true,
      post_cwd_changed_hook = function()
        require("auto-session.session-lens").refresh()
      end,
    },
    post_restore_cmds = { change_nvim_tree_dir, "NvimTreeRefresh", "NvimTreeOpen" },
    pre_save_cmds = { "NvimTreeClose" },
  }, config.opts))

  -- Set up key mappings with which-key.nvim
  local wk_ok, wk = pcall(require, "which-key")
  if wk_ok then
    wk.add(config.keys)
  else
    for _, keymap in ipairs(config.keys) do
      vim.keymap.set("n", keymap[1], keymap[2], { desc = keymap.desc })
    end
  end

  -- Automatic session picker on startup
  if config.autoshow_picker then
    vim.api.nvim_create_autocmd("VimEnter", {
      group = vim.api.nvim_create_augroup("AutoSessionPicker", { clear = true }),
      nested = true,
      callback = function()
        if vim.fn.argc() == 0 then -- Only when opening without file arguments
          vim.schedule(function()
            local ok, lens = pcall(require, "auto-session.session-lens")
            if ok then
              print "  Loading available sessions..."
              lens.search_session()
            else
              vim.notify("Session lens not available", vim.log.levels.WARN)
            end
          end)
        end
      end,
    })
  end
end

return M
