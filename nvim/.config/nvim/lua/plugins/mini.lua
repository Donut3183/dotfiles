-- lua/plugins/mini.lua
return {
  {
    "echasnovski/mini.nvim",
    version = false,
    event   = "VeryLazy",
    config = function()
      -- Text editing
      require("mini.pairs")   .setup({})
      require("mini.comment") .setup({ mappings = {
          comment = "gc",
          comment_line = "gcc",
          comment_visual = "gc",
          textobject = "gc";
        },
    })
      require("mini.surround").setup({})
      require("mini.ai")      .setup({})
      require("mini.align")   .setup({})
      require("mini.completion").setup({})
      require("mini.move")    .setup({})
      require("mini.operators").setup({})
      require("mini.snippets").setup({})
      require("mini.splitjoin").setup({})

      -- General workflow
      require("mini.basics")   .setup({})
      require("mini.bracketed").setup({})
      require("mini.bufremove").setup({})

      -- Clue: full custom config
      local clue = require("mini.clue")
      clue.setup({
        triggers = {
          { mode = 'n', keys = '<Leader>' },
          { mode = 'x', keys = '<Leader>' },
          { mode = 'i', keys = '<C-x>' },
          { mode = 'n', keys = 'g' },
          { mode = 'x', keys = 'g' },
          { mode = 'n', keys = "'" },
          { mode = 'n', keys = '`' },
          { mode = 'x', keys = "'" },
          { mode = 'x', keys = '`' },
          { mode = 'n', keys = '"' },
          { mode = 'x', keys = '"' },
          { mode = 'i', keys = '<C-r>' },
          { mode = 'c', keys = '<C-r>' },
          { mode = 'n', keys = '<C-w>' },
          { mode = 'n', keys = 'z' },
          { mode = 'x', keys = 'z' },
        },
        clues = {
          clue.gen_clues.builtin_completion(),
          clue.gen_clues.g(),
          clue.gen_clues.marks(),
          clue.gen_clues.registers(),
          clue.gen_clues.windows(),
          clue.gen_clues.z(),
        },
        window = {
          delay       = 300,
          config      = { border = 'rounded', width = 'auto' },
          scroll_down = '<C-d>',
          scroll_up   = '<C-u>',
        },
      })

      -- Additional workflow modules
      require("mini.diff")    .setup({})
      require("mini.extra")   .setup({})
      require("mini.files")   .setup({})
      require("mini.git")     .setup({})
      require("mini.jump")    .setup({})
      require("mini.jump2d")  .setup({})
      require("mini.misc")    .setup({})
      require("mini.pick")    .setup({})
      require("mini.sessions").setup({})
      require("mini.visits")  .setup({})

      -- Appearance
      require("mini.base16").setup({
        palette = {
          base00 = "#112641", base01 = "#3a475e", base02 = "#606b81",
          base03 = "#8691a7", base04 = "#d5dc81", base05 = "#e2e98f",
          base06 = "#eff69c", base07 = "#fcffaa", base08 = "#ffcfa0",
          base09 = "#cc7e46", base0A = "#46a436", base0B = "#9ff895",
          base0C = "#ca6ecf", base0D = "#42f7ff", base0E = "#ffc4ff",
          base0F = "#00a5c5",
        },
      })
      require("mini.colors")     .setup({})
      require("mini.cursorword") .setup({})
      -- require("mini.hipatterns") .setup({})
      require("mini.hues")       .setup({
        background = "#11262d",
        foreground = "#c0c8cc",
      })
      require("mini.icons")      .setup({})
      require("mini.indentscope").setup({})
      require("mini.map")        .setup({})
      require("mini.notify")     .setup({})
      require("mini.starter")    .setup({})
      require("mini.statusline") .setup({})
      require("mini.tabline")    .setup({})
      require("mini.trailspace") .setup({})

      -- Other utilities
      require("mini.fuzzy") .setup({})
      require("mini.doc")   .setup({})
      -- (mini.test is more for writing plugin tests, so you can omit it here)
    end,
  },
}
