-- Map Leader key
vim.g.mapleader = ' '

-- Define map as keybind
local map = vim.api.nvim_set_keymap
local optf = { noremap = true, silent = false }
local opt = { noremap = true, silent = true }

map("n", "<S-l>", "<cmd>Lazy<cr>", {})

-- Some useful keybinds VSCode move line keybind
map('n', '<Left>', '<C-w>h', optf)
map('n', '<Down>', '<C-w>j', opt)
map('n', '<Up>', '<C-w>k', opt)
map('n', '<Right>', '<C-w>l', opt)

map('n', 'K', "<cmd>move .-2<CR>==", opt)
map('n', 'J', "<cmd>move .+1<CR>==", opt)
map('v', 'K', "<cmd>move '<-2<CR>gv-gv", opt)
map('v', 'J', "<cmd>move '>+1<CR>gv-gv", opt)

-- buffer movement
map('n', '<TAB>', '<cmd>bn<CR>', opt)
map('n', '<S-TAB>', '<cmd>bp<CR>', opt)
map('n', '<M-TAB>', '<cmd>bd<CR>', opt)

-- Move between panes quickly
map('n', '<C-h>', '<C-w>h', optf)
map('n', '<C-l>', '<C-w>l', optf)
map('n', '<C-j>', '<C-w>j', optf)
map('n', '<C-k>', '<C-w>k', optf)

-- Get out of insert mode quickly
map('i', '<C-k>', '<ESC>', optf)

-- Indent
map('v', '<', '<gv', optf)
map('v', '>', '>gv', optf)

-- Automatically close brackets, parethesis, and quotes
map("i", "'", "''<left>", opt)
map("i", "\"", "\"\"<left>", opt)
map("i", "(", "()<left>", opt)
map("i", "[", "[]<left>", opt)
map("i", "{", "{}<left>", opt)
map("i", "{;", "{};<left><left>", opt)
map("i", "/*", "/**/<left><left>", opt)

