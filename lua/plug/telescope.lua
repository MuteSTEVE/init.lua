local PLUG = {
  'nvim-telescope/telescope.nvim',
  dependencies = 'nvim-lua/plenary.nvim',
  lazy = true,
  event = { "BufReadPost", "BufNewFile" },
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
  local it = icons.telescope

  telescope.setup {
    defaults = {
      prompt_prefix = it.find .. " ",
      selection_caret = it.select .. " ",
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
