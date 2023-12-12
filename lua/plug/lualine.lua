local PLUG = {
  'nvim-lualine/lualine.nvim',
  dependencies = 'kyazdani42/nvim-web-devicons',
  event = { "BufReadPost", "BufNewFile", "InsertEnter" },
}

function PLUG.config()
  local lualine_ok, lualine = pcall(require, 'lualine')
  if not lualine_ok then
    return
  end
  local icons_ok, icons = pcall(require, 'core.icons')
  if not icons_ok then
    return
  end
  local ic = icons.lualine

  local progress_bar = function()
    local current_line = vim.fn.line(".")
    local total_lines = vim.fn.line("$")
    local chars = { ic.__1, ic.__2, ic.__3, ic.__4, ic.__5, ic.__6, ic.__7, ic.__8, ic.__9 }
    local line_ratio = current_line / total_lines
    local index = math.ceil(line_ratio * #chars)
    return chars[index]
  end

  local is = icons.signs
  lualine.setup {
    options = {
      icons_enabled = true,
      theme = 'onedark',
      component_separators = { left = '', right = ''},
      section_separators = { left = '', right = ''},
      transparent = true,
    },
    sections = {
      -- lualine_a = { {'mode', fmt = function(s) return mode_map[s] or s end} },
      lualine_a = { 'filename' },
      lualine_b = {'branch', 'diff', 'diagnostics'},
      lualine_c = { 'os.date(%)'},
      lualine_x = {
        "os.date('%b %d %Y - %I:%M')",
        'encoding',
        'fileformat',
        'filetype',
      },
      lualine_y = {'progress'},
      lualine_z = {progress_bar}
    },
    sources = { 'nvim_diagnostic' },
    symbols = { error = is.Error, warn = is.Warn, info = is.Info },
  }
  vim.cmd("set laststatus=3")
end

return PLUG
