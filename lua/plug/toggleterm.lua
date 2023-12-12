local PLUG = {
  'akinsho/toggleterm.nvim',
  lazy = true,
  cmd = "ToggleTerm",
  event = { "BufReadPost", "BufNewFile" },
  keys = {
    { "<A-f>", "<cmd>ToggleTerm direction=float<cr>"},
    { "<A-h>", "<cmd>ToggleTerm size=15 direction=horizontal<cr>" },
    { "<A-v>", "<cmd>ToggleTerm size=60 direction=vertical<cr>" }
  }
}

function PLUG.config()
  local toggleterm_ok, toggleterm = pcall(require, "toggleterm")
  if not toggleterm_ok then
    return
  end

  toggleterm.setup({
  size = 30,
  open_mapping = [[<c-\>]],
  shade_filetypes = {},
  shade_terminals = true,
  shading_factor = 1,
  start_in_insert = true,
  persist_size = true,
  direction = 'float'
})

vim.cmd([[
  command! -nargs=0 Ncmpcpp lua require('toggleterm').exec('ncmpcpp ; exit', 1)
]])
end

return PLUG
