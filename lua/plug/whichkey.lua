local PLUG = {
  'folke/which-key.nvim',
  event = "VeryLazy",
}

function PLUG.config()
  local which_key_ok, which_key = pcall(require, "which-key")
  if not which_key_ok then
    return
  end

  local setup = {
    plugins = {
      marks = true, -- shows a list of your marks on ' and `
      registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
      spelling = {
        enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
        suggestions = 20, -- how many suggestions should be shown in the list?
      },
      -- the presets plugin, adds help for a bunch of default keybindings in Neovim
      -- No actual key bindings are created
      presets = {
        operators = false, -- adds help for operators like d, y, ... and registers them for motion / text object completion
        motions = true, -- adds help for motions
        text_objects = true, -- help for text objects triggered after entering an operator
        windows = true, -- default bindings on <c-w>
        nav = true, -- misc bindings to work with windows
        z = true, -- bindings for folds, spelling and others prefixed with z
        g = true, -- bindings for prefixed with g
      },
    },
    -- add operators that will trigger motion and text object completion
    -- to enable all native operators, set the preset / operators plugin above
    -- operators = { gc = "Comments" },
    key_labels = {
      -- override the label used to display some keys. It doesn't effect WK in any other way.
      -- For example<cmd>
      -- ["<space>"] = "SPC",
      -- ["<cr>"] = "RET",
      -- ["<tab>"] = "TAB",
    },
    icons = {
      breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
      separator = "➜", -- symbol used between a key and it's label
      group = "+", -- symbol prepended to a group
    },
    popup_mappings = {
      scroll_down = "<c-d>", -- binding to scroll down inside the popup
      scroll_up = "<c-u>", -- binding to scroll up inside the popup
    },
    window = {
      border = "rounded", -- none, single, double, shadow
      position = "bottom", -- bottom, top
      margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
      padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
      winblend = 0,
    },
    layout = {
      height = { min = 4, max = 25 }, -- min and max height of the columns
      width = { min = 20, max = 50 }, -- min and max width of the columns
      spacing = 3, -- spacing between columns
      align = "left", -- align columns left, center or right
    },
    ignore_missing = true, -- enable this to hide mappings for which you didn't specify a label
    hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^<cmd>", "^ " }, -- hide mapping boilerplate
    show_help = true, -- show help message on the command line when the popup is visible
    triggers = "auto", -- automatically setup triggers
    -- triggers = {"<leader>"} -- or specify a list manually
    triggers_blacklist = {
      -- list of mode / prefixes that should never be hooked by WhichKey
      -- this is mostly relevant for key maps that start with a native binding
      -- most people should not need to change this
      i = { "j", "k" },
      v = { "j", "k" },
    },
  }

  local opts = {
    mode = "n", -- NORMAL mode
    prefix = "<leader>",
    buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = true, -- use `nowait` when creating keymaps
  }

  local mappings = {
    u = { "<cmd>lua require('undotree').toggle()<cr>", "Undotree" },
    x = { "<cmd>!chmod +x %<CR>", "Make executable"  },
    m = { "<cmd>Ncmpcpp<cr>", "Ncmpcpp music player" },
    M = { "<cmd>Mason<cr>", "Mason LSP"},
    g = { "<cmd>LazyGit<cr>", "LazyGit" },
    b = {
      "<cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown{previewer = false})<cr>",
      "Buffers",
    },
    n = { "<cmd>NvimTreeFindFileToggle<cr>", "Explorer" },
    w = { "<cmd>w!<CR>", "Save" },
    S = { "<cmd>so %<cr>", "Source the config" },
    q = { "<cmd>q!<CR>", "Quit" },
    c = { "<cmd>Bdelete!<CR>", "Close Buffer" },
    h = { "<cmd>nohlsearch<CR>", "No Highlight" },
    f = {
      "<cmd>lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown{previewer = false})<cr>",
      "Find files",
    },
    F = { "<cmd>Telescope live_grep theme=ivy<cr>", "Find Text" },
    H = { "<cmd>Telescope oldfiles theme=ivy<cr>", "Open [r]ecent file" },

    l = {
      name = "LSP",
      f = {
        "<cmd>Telescope diagnostics<cr>",
        "Workspace Diagnostics",
      },
      i = { "<cmd>LspInfo<cr>", "[I]nfo Connected Language Servers" },
      k = { "<cmd>lua vim.lsp.buf.signature_help()<cr>", "[k] Signature Help" },
      K = { "<cmd>Lspsaga hover_doc<cr>", "[K] Hover Commands" },
      w = { '<cmd>lua vim.lsp.buf.add_workspace_folder()<cr>', "Add [w]orkspace Folder" },
      W = { '<cmd>lua vim.lsp.buf.remove_workspace_folder()<cr>', "Remove [W]orkspace Folder" },
      l = {
        '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<cr>',
        "[l]ist Workspace Folders"
      },
      t = { '<cmd>lua vim.lsp.buf.type_definition()<cr>', "[t]ype Definition" },
      d = { '<cmd>lua vim.lsp.buf.definition()<cr>', "Go To [d]efinition" },
      D = { '<cmd>lua vim.lsp.buf.declaration()<cr>', "Go To [D]eclaration" },
      r = { '<cmd>lua vim.lsp.buf.references()<cr>', "Refe[r]ences" },
      R = { '<cmd>Lspsaga rename<cr>', "[r]ename" },
      a = { '<cmd>Lspsaga code_action<cr>', "Code [a]ction" },
      e = { '<cmd>Lspsaga show_line_diagnostics<cr>', "Show Lin[e] Diagnostics" },
      n = { '<cmd>Lspsaga diagnostic_jump_next<cr>', "Go To [n]ext Diagnostic" },
      N = { '<cmd>Lspsaga diagnostic_jump_prev<cr>', "[N] Go To Previous Diagnostic" }
    },

    s = {
      name = "Search",
      b = { "<cmd>Telescope git_branches<cr>", "Checkout [b]ranch" },
      c = { "<cmd>Telescope colorscheme<cr>", "[C]olorscheme" },
      h = { "<cmd>Telescope help_tags<cr>", "Find [H]elp" },
      M = { "<cmd>Telescope man_pages<cr>", "[M]an Pages" },
      r = { "<cmd>Telescope oldfiles<cr>", "Open [r]ecent file" },
      R = { "<cmd>Telescope registers<cr>", "[R]egisters" },
      k = { "<cmd>Telescope keymaps<cr>", "[K]eymaps" },
      C = { "<cmd>Telescope commands<cr>", "[C]ommands" },
    },

    t = {
      name = "Terminal",
      f = { "<cmd>ToggleTerm direction=float<cr>", "[F]loat terminal" },
      h = { "<cmd>ToggleTerm size=10 direction=horizontal<cr>", "[H]orizontal terminal" },
      v = { "<cmd>ToggleTerm size=80 direction=vertical<cr>", "[V]ertical terminal" },
    },
  }

  which_key.setup(setup)
  which_key.register(mappings, opts)
end

return PLUG
