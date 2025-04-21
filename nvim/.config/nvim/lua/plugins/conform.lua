return  { {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    -- lazy = false,
    event = { "BufWritePre", "BufNewFile", "BufReadPre" },
    cmd = { "ConformInfo" },
    config = function()
      require "configs.conform"
    end,
  },
  }
