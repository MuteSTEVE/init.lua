-- Map Leader key
vim.g.mapleader = ' '

-- Define map as keybind
local map = vim.api.nvim_set_keymap
local nrs = { noremap = true, silent = false }
local nr = { noremap = true, silent = true }

map("n", "<S-l>", "<cmd>Lazy<cr>", {})
map("n", "<S-m>", "<cmd>Mason<cr>", {})

-- Some useful keybinds VSCode move line keybind
map('n', '<Left>', '<C-w>h', nrs)
map('n', '<Down>', '<C-w>j', nr)
map('n', '<Up>', '<C-w>k', nr)
map('n', '<Right>', '<C-w>l', nr)

map('n', 'K', "<cmd>move .-2<CR>==", nr)
map('n', 'J', "<cmd>move .+1<CR>==", nr)
map('v', 'K', "<cmd>move '<-2<CR>gv-gv", nr)
map('v', 'J', "<cmd>move '>+1<CR>gv-gv", nr)

-- buffer movement
map('n', 'Z', '<cmd>bp<CR>', nr)
map('n', 'C', '<cmd>bn<CR>', nr)
map('n', 'X', '<cmd>bd<CR>', nr)

-- Move between panes quickly
map('n', '<C-h>', '<C-w>h', nrs)
map('n', '<C-l>', '<C-w>l', nrs)
map('n', '<C-j>', '<C-w>j', nrs)
map('n', '<C-k>', '<C-w>k', nrs)

-- Get out of insert mode quickly
map('i', '<C-k>', '<ESC>', nrs)

-- Indent
map('v', '<', '<gv', nrs)
map('v', '>', '>gv', nrs)

-- moving the cursor in insert mode
map('i', '<C-h>', '<Left>', nr)
map('i', '<C-l>', '<Right>', nr)

-- exiting terminal insert mode and automatically moving different pane asynchronously
map('n', '<A-q>', '<cmd>q!<CR>', nr)
map('t', '<ESC>', '<C-\\><C-n>', nr)
map('t', '<C-h>', '<C-\\><C-n><C-w>h', nrs)
map('t', '<C-l>', '<C-\\><C-n><C-w>l', nrs)
map('t', '<C-j>', '<C-\\><C-n><C-w>j', nrs)
map('t', '<C-k>', '<C-\\><C-n><C-w>k', nrs)
map('t', '<A-q>', '<C-\\><C-n><cmd>q!<CR>', nr)
