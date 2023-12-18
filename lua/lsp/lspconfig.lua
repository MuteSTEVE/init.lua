local PLUG = {
  'neovim/nvim-lspconfig',
  event = { "BufReadPost", "BufNewFile", },
}

function PLUG.config()
  local lspconfig_ok, lspconfig = pcall(require, "lspconfig")
  if not lspconfig_ok then
    return
  end

  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true

  local language_servers = lspconfig.util.available_servers()
  for _, ls in ipairs(language_servers) do
    lspconfig[ls].setup({
      capabilities = capabilities,
      Lua = {
        diagnostics = {{ global = {'vim'}}}
      },
    })
  end

  -- langservers
  local langservers = {
    'html',
    'cssls',
    'cssmodules_ls',
    'unocss',
    'phpactor',
    'intelephense',
    'tsserver',
    'pylsp',
    'lua_ls',
    'vimls'
  }

  for _, server in ipairs(langservers) do
    lspconfig[server].setup {
      capabilities = capabilities,
      Lua = {
        diagnostics = {{ global = {'vim'}}}
      },
    }
  end

  lspconfig.emmet_ls.setup {
    capabilities = capabilities,
    Lua = {
      diagnostics = {{ global = {'vim'}}}
    },
    filetypes = {
      "css",
      "php",
      "eruby",
      "html",
      "javascript",
      "javascriptreact",
      "less",
      "sass",
      "scss",
      "svelte",
      "pug",
      "typescriptreact",
      "vue"
    },
    init_options = {
      html = {
        options = {
          ["bem.enabled"] = true,
        },
      }
    }
  }

  lspconfig.lua_ls.setup {
    settings = {
      Lua = {
        runtime = {
          -- Tell the language server which version of Lua you're using
          -- (most likely LuaJIT in the case of Neovim)
          version = 'LuaJIT',
        },
        diagnostics = {
          -- Get the language server to recognize the `vim` global
          globals = {
            'vim',
            'require'
          },
        },
        workspace = {
          -- Make the server aware of Neovim runtime files
          library = vim.api.nvim_get_runtime_file("", true),
        },
        -- Do not send telemetry data containing a randomized but unique identifier
        telemetry = {
          enable = false,
        },
      },
    },
  }

  -- Set up signs
  local icons_ok, icons = pcall(require, 'core.icons')
  if not icons_ok then
    return
  end
  local IS = icons.signs
  local signs = { Error = IS.Error, Warn = IS.Warn, Hint = IS.Hint, Info = IS.Info }
  for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
  end
end

return PLUG
