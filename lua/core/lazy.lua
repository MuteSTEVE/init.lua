local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

local lazy_ok, lazy = pcall(require, "lazy")
if not lazy_ok then
  return
end

lazy.setup {
  spec = {
    { import = "plug" },
    { import = "git" },
    { import = "lsp" },
  },

  cache = { enabled = true },
  defaults = { lazy = true },
  install = { missing = true }
}
