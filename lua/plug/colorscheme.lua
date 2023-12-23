local PLUG = {
  'navarasu/onedark.nvim',
  lazy = false,
  priority = 1000,
}

function PLUG.config()
  local onedark_ok, onedark = pcall(require, 'onedark')
  if not onedark_ok then
    return
  end

  onedark.setup({
    style = 'warmer',
    transparent = true,
    code_style = { comments = 'italic' },
    lualine = { transparent = true },
    diagnostics = {
      darker = true, -- darker colors for diagnostic
      undercurl = true,   -- use undercurl instead of underline for diagnostics
      background = true,    -- use background color for virtual text
    },
  })

  onedark.load()
  vim.cmd('colorscheme onedark')
end

return PLUG
