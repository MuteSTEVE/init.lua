local PLUG = {
  'nvim-telescope/telescope.nvim',
  dependencies = 'nvim-lua/plenary.nvim',
  lazy = true,
  cmd = "Telescope",
}

function PLUG.config()
  local telescope_ok, telescope = pcall(require, 'telescope')
  if not telescope_ok then
    return
  end
  local actions_ok, actions = pcall(require, 'telescope.actions')
  if not actions_ok then
    return
  end
  local icons_ok, icons = pcall(require, 'core.icons')
  if not icons_ok then
    return
  end
  telescope.load_extension("noice")
  local ITL = icons.telescope

  telescope.setup {
    defaults = {
      prompt_prefix = ITL.find .. " ",
      selection_caret = ITL.select .. " ",
      mappings = {
        i = {
          ["<C-j>"] = actions.move_selection_next,
          ["<C-k>"] = actions.move_selection_previous,
          ["<C-f>"] = actions.close,
          ["<leader>b"] = actions.close,
          ["<leader>u"] = actions.close,
          ["<esc>"] = actions.close,
        },
      },
    }
  }
end

return PLUG
