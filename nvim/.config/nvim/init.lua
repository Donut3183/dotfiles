-- 1) Leaders
vim.g.mapleader       = " "
vim.g.maplocalleader  = " "

-- init.lua

--------------------------------------------------------------------------------
-- 1) Bootstrap folke/lazy.nvim
--------------------------------------------------------------------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

--------------------------------------------------------------------------------
-- 2) Tell lazy.nvim where your plugin specs live
--------------------------------------------------------------------------------
-- Since your specs are in lua/plugins/init.lua, use "plugins" as the module path
require("lazy").setup("plugins", {
  -- Optional lazy.nvim settings go here, e.g.:
  -- defaults = { lazy = true, version = "*" },
})

--------------------------------------------------------------------------------
-- 3) Load the rest of your Neovim config
--------------------------------------------------------------------------------
require("options")    -- lua/options.lua
require("mappings").setup()   -- lua/mappings.lua
require("autocmds")   -- lua/autocmds.lua

