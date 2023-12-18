local PLUG = {
  'kkharji/lspsaga.nvim',
  lazy = true,
  event = { "BufReadPost", "BufNewFile", },
  cmd = "Lspsaga"
}

function PLUG.config()
  local lspsaga_ok, lspsaga = pcall(require, 'lspsaga')
  if not lspsaga_ok then
    return
  end
  local icons_ok, icons = pcall(require, 'core.icons')
  if not icons_ok then
    return
  end
  local IL = icons.lspsaga

  lspsaga.setup { -- defaults ...
    debug = false,
    use_saga_diagnostic_sign = true,
    -- diagnostic sign
    error_sign = IL.error_sign,
    warn_sign = IL.warn_sign,
    hint_sign = IL.hint_sign,
    infor_sign = IL.infor_sign,
    diagnostic_header_icon = IL.diagnostic_header_icon,
    -- code action title icon
    code_action_icon = " ",
    code_action_prompt = {
      enable = true,
      sign = true,
      sign_priority = 40,
      virtual_text = true,
    },
    finder_definition_icon = IL.finder_definition_icon,
    finder_reference_icon = IL.finder_reference_icon,
    max_preview_lines = 10,
    finder_action_keys = {
      open = "o",
      vsplit = "s",
      split = "i",
      quit = "q",
      scroll_down = "<C-f>",
      scroll_up = "<C-b>",
    },
    code_action_keys = {
      quit = "q",
      exec = "<CR>",
    },
    rename_action_keys = {
      quit = "<C-c>",
      exec = "<CR>",
    },
    definition_preview_icon = IL.definition_preview_icon,
    border_style = "single",
    rename_prompt_prefix = IL.rename_prompt_prefix,
    rename_output_qflist = {
      enable = false,
      auto_open_qflist = false,
    },
    server_filetype_map = {},
    diagnostic_prefix_format = "%d. ",
    diagnostic_message_format = "%m %c",
    highlight_prefix = false,
  }

  local map = vim.api.nvim_set_keymap
  map("n", "<C-u>", "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1, '<c-u>')<cr>", { noremap = true, silent = true })
  map("n", "<C-d>", "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(1, '<c-d>')<cr>", { noremap = true, silent = true })
end

return PLUG
