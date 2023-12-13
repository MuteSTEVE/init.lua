local PLUG = {
  'jose-elias-alvarez/null-ls.nvim',
  event = { "BufReadPost", "BufNewFile", },
}

function PLUG.config()
  local null_ls_ok, null_ls = pcall(require, 'null-ls')
  if not null_ls_ok then
    return
  end
  local diagnostics = null_ls.builtins.diagnostics
  local formatting = null_ls.builtins.formatting
  -- local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

  null_ls.setup({
    sources = {
      formatting.prettier,
      formatting.black,
      formatting.gofmt,
      -- formatting.mypy,
      formatting.ruff,
      formatting.lua_format.with({
        extra_args = {
          '--no-keep-simple-function-one-line', '--no-break-after-operator', '--column-limit=100',
          '--break-after-table-lb', '--indent-width=2'
        }
      }),
      formatting.isort,
      formatting.codespell.with({filetypes = {'markdown'}}),

      -- diagnostics.mypy,
      diagnostics.ruff,
    },
    -- on_attach = function(client, bufnr)
    --   if client.supports_method["textDocument/formatting"] then
    --     vim.api.nvim_clear_autocmds({
    --       group = augroup,
    --       buffer = bufnr,
    --     })
    --     vim.api.nvim_create_autocmd("BufWritePre", {
    --       group = augroup,
    --       buffer = bufnr,
    --       callback = function ()
    --         vim.lsp.buf.format({ bufnr = bufnr })
    --       end
    --     })
    --   end
    -- end,
  })
end

return PLUG
