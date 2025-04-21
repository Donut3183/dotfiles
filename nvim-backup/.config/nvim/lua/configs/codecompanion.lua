-- ~/.config/nvim/lua/codecompanion.lua

require("codecompanion").setup {

  -- Core configuration
  log_level = "info",
  strategy = "toggle",
  adapters = {

    copilot = function()
      return require("codecompanion.adapters").extend("copilot", {
        -- Add any custom logic here
        -- For example, you can modify the request or response
        -- before sending it to the OpenAI API.
        --
        model = "o3-mini",
        parameters = {
          temperature = 0.7,
          max_completion_tokens = 2048,
        },
        context = function()
          return {
            type = "project",
            max_files = 8,
            file_types = { ".c", ".h", ".md", ".txt", ".clangd", ".clang-format" },
            exclude_dirs = { ".git", "node_modules", "venv" },
          }
        end,
      })
    end,
    openai = function()
      return require("codecompanion.adapters").extend("openai", {
        -- Add any custom logic here
        -- For example, you can modify the request or response
        -- before sending it to the OpenAI API.
        --
        model = "o3-mini",
        api_key = os.getenv "OPENAI_API_KEY",
        parameters = {
          temperature = 0.7,
          max_completion_tokens = 2048,
        },
        context = function()
          return {
            type = "project",
            max_files = 8,
            file_types = { ".c", ".h", ".md", ".txt", ".clangd", ".clang-format" },
            exclude_dirs = { ".git", "node_modules", "venv" },
          }
        end,
      })
    end,

    gemini = function()
      return require("codecompanion.adapters").extend("gemini", {
        -- Add any custom logic for Google Gemini here
        model = "gemini-2.5-pro-exp-03-25",
        api_key = os.getenv "GEMINI_API_KEY", -- Ensure the correct environment variable is set
        parameters = {},
        context = function()
          return {
            type = "project",
            max_files = 8,
            file_types = { ".c", ".h", ".md", ".txt", ".clangd", ".clang-format" },
            exclude_dirs = { ".git", "node_modules", "venv" },
          }
        end,
      })
    end,
  },

  -- Adapters setup
  strategies = {
    chat = {
      adapter = "copilot",
    },
  },
  -- Interface settings
  chat = {
    border = "rounded",
    width = 0.8,
    height = 0.8,
    keymaps = {
      close = { "jk", "<Esc>" },
      submit = "<C-s>",
      yank_last = "<leader>y",
    },
  },

  display = {
    action_palette = {
      provider = "telescope", -- Assuming you want to use Telescope
      -- telescope_opts = {
      --   defaults = {
      --     set_env = {
      --       TelescopeResultsNumber = true,
      --     },
      --     layout_config = {
      --       prompt_position = "bottom",
      --     },
      --     sorting_strategy = "ascending",
      --   },
      -- },
    },

    -- User context
    user = {
      name = "Developer",
      role = "Senior Engineer",
      preferences = {
        language = "English",
        verbosity = "concise",
      },
    },
  },
}

-- require "configs.fidget-spinner"
-- Keybindings
vim.keymap.set("n", "<leader>dc", "<cmd>CodeCompanionChat<cr>", { desc = "Toggle chat" })
vim.keymap.set("n", "<leader>da", "<cmd>CodeCompanionActions<cr>", { desc = "Action palette" })

-- Optional: Visual mode code actions
vim.keymap.set("v", "<leader>da", function()
  vim.cmd "CodeCompanionActions"
end, { desc = "Action palette (visual)" })
