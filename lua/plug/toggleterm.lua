local PLUG = {
  'akinsho/toggleterm.nvim',
  lazy = true,
  cmd = "ToggleTerm",
  keys = {
    { "<A-m>", "<cmd>Ncmpcpp<CR>" },
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
    open_mapping = [[<A-f>]],
    start_in_insert = true,
    direction = 'float',
    float_opts = { border = "curved" }
  })

  vim.cmd([[ command! Ncmpcpp lua require("toggleterm").exec(' ncmpcpp ; exit') ]])

  local map = vim.api.nvim_set_keymap
  local nr = { noremap = true, silent = true }
  map('t', '<ESC>', '<C-\\><C-n>', nr)
  map('t', '<C-h>', '<C-\\><C-n><C-w>h', nr)
  map('t', '<C-l>', '<C-\\><C-n><C-w>l', nr)
  map('t', '<C-j>', '<C-\\><C-n><C-w>j', nr)
  map('t', '<C-k>', '<C-\\><C-n><C-w>k', nr)
  map('t', '<A-q>', '<C-\\><C-n><cmd>q!<CR>', nr)
  map('t', '<A-f>', '<C-\\><C-n><cmd>q!<CR>', nr)
  map('t', '<A-v>', '<C-\\><C-n><cmd>q!<CR>', nr)
  map('t', '<A-h>', '<C-\\><C-n><cmd>q!<CR>', nr)
  map('t', '<A-m>', '<C-\\><C-n><cmd>q!<CR>', nr)
end

return PLUG
