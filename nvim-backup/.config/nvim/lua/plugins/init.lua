return {
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {
      -- configuration options
      labels = "asdfghjklqwertyuiopzxcvbnm",
      search = {
        -- search/jump in all windows
        multi_window = true,
        -- search direction
        forward = true,
        -- when `false`, find only matches in the given direction
        wrap = true,
      },
    },
    -- stylua: ignore
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
      { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
    },
  },

  {
    "augmentcode/augment.vim",
    event = "VeryLazy",
    config = function()
      require "configs.augment"
    end,
  },

  {
    "iamcco/markdown-preview.nvim",
    build = "cd app && npm install",
    ft = { "markdown" },
    cmd = { "MarkdownPreview", "MarkdownPreviewStop" },
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
  },

  -- install nvim-telescop plugin
  {
    "nvim-telescope/telescope.nvim",
    lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-ui-select.nvim",
      "nvim-telescope/telescope-fzf-native.nvim",
    },
    config = function()
      require("telescope").setup {
        defaults = {
          layout_strategy = "flex",
          layout_config = {
            flex = { flip_columns = 120 },
          },
          sorting_strategy = "ascending",
          prompt_prefix = "🔍 ",
          selection_caret = "➤ ",
          entry_prefix = "  ",
          winblend = 0,
        },
      }
      require("telescope").load_extension "ui-select"
    end,
  },
  { "nvim-lua/plenary.nvim", branch = "master" },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require "configs.lualine"
    end,
  },
  -- {
  --   "github/copilot.vim",
  --   lazy = false,
  -- },
  {
    "olimorris/codecompanion.nvim",
    event = "BufRead",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "nvim-telescope/telescope.nvim",
      "j-hui/fidget.nvim",
    },
    config = function()
      require "configs.codecompanion"
    end,
  },
  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require "configs.nvim-tree"
    end,
  },
  {
    "rmagatti/auto-session",
    lazy = false,

    config = function()
      require("configs.auto-session").init_plugin()
    end,
  },
  {
    "rickhowe/diffchar.vim",
    lazy = false, -- Load immediately when in diff mode
    config = function()
      vim.g.DiffUnit = "Word1" -- Enable word-level diff highlighting
    end,
  },
  {
    "Donut3183/ChatGPT.nvim",
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
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
    },
    config = function()
      require("mason").setup()

      -- LSP Servers
      require("mason-lspconfig").setup {
        ensure_installed = {
          -- Core C/C++
          "clangd",
          "ccls",
          "copilot-language-server",
          "cmake-language-server",
          "matlab-language-server", -- MATLAB language server

          -- Hardware/Embedded
          "rust_analyzer",
          "verible",
          "vhdl-tool",

          -- Scripting/Tooling
          "bashls",
          "pyright",
          "lua_ls",

          -- Documentation
          "marksman",
          "texlab", -- LaTeX language server
          -- "ltex-ls", -- LaTeX spell check + grammar
        },
        automatic_installation = true,
      }

      -- Extended Tools
      require("mason-tool-installer").setup {
        ensure_installed = {
          -- C/C++ Toolchain
          "cpptools",
          "codelldb",
          "clang-format",

          -- Hardware Tools
          "verilog-formatter",
          "vhdl-formatter",
          "gtkwave",

          -- Embedded Debugging
          "openocd",
          "stlink",

          -- LaTeX Tools
          "latexindent", -- Primary LaTeX formatter
          "texlab", -- Also provides formatting
          "chktex", -- LaTeX linter

          -- MATLAB Tools
          "mlint", -- MATLAB linter (requires MATLAB install)
          "matlab-formatter", -- Community formatting tool

          -- General Utilities
          "cmakelang",
          "codespell",
          "shellcheck",
        },
        auto_update = true,
      }
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        -- Core
        "c",
        "cpp",
        "cmake",
        "make",

        -- Hardware
        "verilog",
        "vhdl",

        -- Embedded
        "devicetree",
        "rust",
        "python",

        -- Tooling
        "bash",
        "json",
        "yaml",

        -- Existing
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
    config = function()
      require "configs.nvim-cmp"
    end,
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
