local PLUG = {
  'lewis6991/gitsigns.nvim',
  event = { "BufReadPost", "BufNewFile" }
}

function PLUG.config()
  local gitsigns_ok, gitsigns = pcall(require, "gitsigns")
  if not gitsigns_ok then
    return
  end
  local icons_ok, icons = pcall(require, 'core.icons')
  if not icons_ok then
    return
  end
  local IG = icons.git

  gitsigns.setup {
    signs = {
      add = { hl = "GitSignsAdd", text = IG.signs, numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
      change = { hl = "GitSignsChange", text = IG.signs, numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
      delete = { hl = "GitSignsDelete", text = IG.signs, numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
      topdelete = { hl = "GitSignsDelete", text = IG.signs, numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
      changedelete = { hl = "GitSignsChange", text = IG.signs, numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
    },
  }
end

return PLUG
