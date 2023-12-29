local PLUG = {
  'utilyre/barbecue.nvim',
  dependencies = "nvim-tree/nvim-web-devicons",
  event = { "BufReadPost", "BufNewFile" },
}

function PLUG.config()
  local status_ok, barbecue = pcall(require, 'barbecue')
  if not status_ok then
    return
  end
  local icons_ok, icons = pcall(require, 'core.icons')
  if not icons_ok then
    return
  end
  local IK = icons.kind_icons

  barbecue.setup({
    attach_navic = true,
    create_autocmd = true,
    include_buftypes = { "" },
    exclude_filetypes = { "netrw", "toggleterm" },
    modifiers = {
      dirname = ":~:.",
      basename = "",
    },
    show_dirname = true,
    show_modified = true,
    modified = function(bufnr) return vim.bo[bufnr].modified end,
    show_navic = true,
    lead_custom_section = function() return " " end,
    custom_section = function() return " " end,
    theme = "auto",
    context_follow_icon_color = false,
    symbols = {
      modified = "+",
      ellipsis = "…",
      separator = "",
    },
    kinds = {
      Array = IK.Array,
      Boolean = IK.Boolean,
      Class = IK.Class,
      Constant = IK.Constant,
      Constructor = IK.Constructor,
      Enum = IK.Enum,
      EnumMember = IK.EnumMember,
      Event = IK.Event,
      Field = IK.Field,
      File = IK.File,
      Function = IK.Function,
      Interface = IK.Interface,
      Key = IK.Keyword,
      Method = IK.Method,
      Module = IK.Module,
      Namespace = IK.Namespace,
      Null = IK.Null,
      Number = IK.Number,
      Object = IK.Object,
      Operator = IK.Operator,
      Package = IK.Package,
      Property = IK.Package,
      String = IK.String,
      Struct = IK.Struct,
      TypeParameter = IK.TypeParameter,
      Variable = IK.Variable,
    },
  })
end

return PLUG
