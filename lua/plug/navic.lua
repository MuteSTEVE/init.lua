local PLUG = {
  'SmiteshP/nvim-navic',
  event = { "BufReadPost", "BufNewFile" },
}

function PLUG.config()
  local navic_ok, navic = pcall(require, "nvim-navic")
  if not navic_ok then
    return
  end
  local lspconfig_ok, lspconfig = pcall(require, 'lspconfig')
  if not lspconfig_ok then
    return
  end
  lspconfig.clangd.setup {
    on_attach = function(client, bufnr)
      navic.attach(client, bufnr)
    end
  }
  local icons_ok, icons = pcall(require, 'core.icons')
  if not icons_ok then
    return
  end
  local IK = icons.kind_icons

  navic.setup {
    icons = {
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
    lsp = {
      auto_attach = true,
      preference = nil,
    },
    highlight = true,
    separator = " > ",
    depth_limit = 0,
    depth_limit_indicator = "..",
    safe_output = true,
    click = false
  }
end

return PLUG
