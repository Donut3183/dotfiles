return {
    {
    "williamboman/mason.nvim",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
    },
    config = function()
      require("mason").setup(

      -- LSP Servers
      require("mason-lspconfig").setup {
        ensure_installed = {
          -- Core C/C++
          "clangd",
          "ccls",
          "cmake-language-server",
          "matlab-language-server", -- MATLAB language server

          -- Scripting/Tooling
          "bashls",
          "pyright",
          "lua_ls",

          -- Documentation
          "marksman",
          "texlab", -- LaTeX language server
          "ltex-ls", -- LaTeX spell check + grammar
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

          -- LaTeX Tools
          "latexindent", -- Primary LaTeX formatter
          "texlab", -- Also provides formatting

          -- General Utilities
          "cmakelang",
          "codespell",
          "shellcheck",
        },
        auto_update = true,
      }
    end,
  },
  }
