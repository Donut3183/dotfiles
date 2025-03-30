local cmp = require "cmp"

cmp.setup {
  completion = {
    -- Disable the automatic popup
    autocomplete = false,
  },
  mapping = {
    -- Define a keybinding to manually trigger the completion popup
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<CR>"] = cmp.mapping.confirm { select = true }, -- Accept currently selected item
    ["<Tab>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
    ["<S-Tab>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
    -- You can include additional mappings here as needed.
  },
  -- Ensure you have sources set up correctly, like buffer, path, etc.
  sources = {
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "buffer" },
    { name = "path" },
    -- Add additional sources as needed
  },
}
