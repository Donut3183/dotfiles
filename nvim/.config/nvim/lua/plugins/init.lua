return {
  {
    "rickhowe/diffchar.vim",
    lazy = false, -- Load immediately when in diff mode
    config = function()
      vim.g.DiffUnit = "Word1" -- Enable word-level diff highlighting
    end,
  },
  {
    "jackMort/ChatGPT.nvim",
    event = "VeryLazy",
    config = function()
      -- require("chatgpt").setup()
      require "configs.chatgpt"
    end,
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "folke/trouble.nvim", -- optional
      "nvim-telescope/telescope.nvim",
      "echasnovski/mini.icons",
    },
  },
  { "barreiroleo/ltex-extra.nvim" },
  {
    "norcalli/nvim-colorizer.lua",
  },
  -- {
  --   "christoomey/vim-tmux-navigator",
  --   lazy = false,
  -- },
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    -- lazy = false,
    event = { "BufWritePre", "BufNewFile", "BufReadPre" },
    cmd = { "ConformInfo" },
    config = function()
      require "configs.conform"
    end,
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("nvchad.configs.lspconfig").defaults()
      require "configs.lspconfig"
    end,
  },

  {
    "williamboman/mason.nvim",
    dependencies = { "williamboman/mason-lspconfig.nvim" },
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup {
        ensure_installed = {
          "lua_ls", -- Lua
          "pyright", -- Python
          "clangd", -- C/C++
          "bashls", -- Bash
          "jsonls", -- JSON
          "yamlls", -- YAML
          "marksman", -- Markdown
          "ltex-ls",
          "matlab-language-server",
          "latexindent",
          "shfmt",
        },
        automatic_installation = true, -- Ensures missing servers install automatically
      }
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim",
        "lua",
        "vimdoc",
        "html",
        "css",
      },
    },
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "L3MON4D3/LuaSnip",
    },
  },

  {
    "lervag/vimtex",
    ft = "tex",
    lazy = false,
    config = function()
      require "configs.vimtexrc"
    end,
  },
}
