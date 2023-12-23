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
  local Terminal = require("toggleterm.terminal").Terminal

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

  local ncmpcpp = Terminal:new({ cmd = "ncmpcpp", hidden = true })
  function _NCMPCPP_TOGGLE()
    ncmpcpp:toggle()
  end
  -- vim.cmd([[
  --   command! -nargs=0 Ncmpcpp lua require('toggleterm').exec(' ncmpcpp ; exit', 1)
  -- ]])

  local map = vim.api.nvim_set_keymap
  local nr = { noremap = true, silent = true }

  map('n', '<A-q>', '<cmd>q!<CR>', nr)
  map('n', '<A-m>', "<cmd>lua _NCMPCPP_TOGGLE()<cr>", nr)
  map('t', '<ESC>', '<C-\\><C-n>', nr)
  map('t', '<C-h>', '<C-\\><C-n><C-w>h', nr)
  map('t', '<C-l>', '<C-\\><C-n><C-w>l', nr)
  map('t', '<C-j>', '<C-\\><C-n><C-w>j', nr)
  map('t', '<C-k>', '<C-\\><C-n><C-w>k', nr)
  map('t', '<A-q>', '<C-\\><C-n><cmd>q!<CR>', nr)
  map('t', '<A-f>', '<C-\\><C-n><cmd>q!<CR>', nr)
  map('t', '<A-v>', '<C-\\><C-n><cmd>q!<CR>', nr)
  map('t', '<A-h>', '<C-\\><C-n><cmd>q!<CR>', nr)
end

return PLUG
