local PLUG = {
  'kevinhwang91/nvim-ufo',
  event = { "BufReadPost", "BufNewFile" },
  dependencies = 'kevinhwang91/promise-async'
}

function PLUG.config()
  local ufo_ok, ufo = pcall(require, "ufo")
  if not ufo_ok then
    return
  end

  vim.o.foldlevelstart = 99
  vim.o.foldenable = true

  vim.keymap.set('n', '=', "<cmd>foldopen<cr>")
  vim.keymap.set('n', '+', ufo.openAllFolds)
  vim.keymap.set('n', '-', "<cmd>foldclose<cr>")
  vim.keymap.set('n', '_', ufo.closeAllFolds)
  vim.keymap.set('n', 'zK', function ()
    local winid = ufo.peekFoldedLinesUnderCursor()
    if not winid then
      vim.lsp.buf.hover()
    end
  end)

  ufo.setup({
    provider_selector = function (bufnr, filetype, buftype)
      return { 'lsp', 'indent' }
    end
  })

  -- ufo to remember_folds
  vim.cmd([[
    augroup remember_folds
    autocmd!
    autocmd BufWinLeave *.* mkview
    autocmd BufWinEnter *.* silent! loadview
    augroup END
  ]])
end

return PLUG
