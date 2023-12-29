local PLUG = {
  'folke/noice.nvim',
  dependencies = { "MunifTanjim/nui.nvim", "rcarriga/nvim-notify" },
  event = "VeryLazy",
}

function PLUG.config()
  local noice_ok, noice = pcall(require, "noice")
  if not noice_ok then
    return
  end

  local notify_ok, notify = pcall(require, 'notify')
  if not notify_ok then
    return
  end

  noice.setup({
    cmdline = {
      view = "cmdline",
      format = {
        search_down = { icon = "󰍉"},
        search_up = { icon = "󰍉"}
      }
    },
    views = {
      cmdline_popup = {
        position = { row = 10, col = "50%" },
      },
    },
  })

  notify.setup({
    background_colour = "Normal",
    fps = 60,
    render = "compact",
    stages = "slide",
    timeout = 3000
  })
end

return PLUG
