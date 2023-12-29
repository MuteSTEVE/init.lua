local PLUG = {
  'akinsho/bufferline.nvim',
  event = { "BufReadPost", "BufNewFile" },
}

function PLUG.config()
  local bufferline_ok, bufferline = pcall(require, "bufferline")
  if not bufferline_ok then
    return
  end

  -- Function to run a shell command and capture its output
  local function capture_shell_command(command)
    local handle = io.popen(command)
    local result = handle:read("*a")
    handle:close()
    return result:gsub("\n$", "") -- Remove trailing newline
  end

  bufferline.setup {
    options = {
      indicator = { style = 'none' },
      modified_icon = '+',
      tab_size = 15,
      offsets = {
        {
          filetype = 'NvimTree',
          text = capture_shell_command("bash -c 'pwd'") .. ' ', -- Run 'bash command pwd'
          highlight = 'Directory',
          text_align = 'center',
        },
      },
      hover = { enabled = true, reveal = {'close'} },
    }
  }
end

return PLUG
