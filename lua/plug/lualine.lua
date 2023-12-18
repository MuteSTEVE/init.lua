local PLUG = {
  'nvim-lualine/lualine.nvim',
  dependencies = 'kyazdani42/nvim-web-devicons',
  event = { "BufReadPost", "BufNewFile", "InsertEnter" },
}

function PLUG.config()
  local status_ok, lualine = pcall(require, "lualine")
  if not status_ok then
    return
  end
  local null_ls_ok, null_ls = pcall(require, "null-ls")
  if not null_ls_ok then
    return
  end
  local null_ls_sources_ok, null_ls_sources = pcall(require, "null-ls.sources")
  if not null_ls_sources_ok then
    return
  end
  local icons_ok, icons = pcall(require, 'core.icons')
  if not icons_ok then
    return
  end

  -- cool function for progress
  local IL = icons.lualine
  local progress = function()
    local current_line = vim.fn.line(".")
    local total_lines = vim.fn.line("$")
    local chars = { IL.__1, IL.__2, IL.__3, IL.__4, IL.__5, IL.__6, IL.__7, IL.__8 }
    local line_ratio = current_line / total_lines
    local index = math.ceil(line_ratio * #chars)
    return chars[index]
  end

  -- start for lsp
  local list_registered_providers_names = function(filetype)
    local available_sources = null_ls_sources.get_available(filetype)
    local registered = {}
    for _, source in ipairs(available_sources) do
      for method in pairs(source.methods) do
        registered[method] = registered[method] or {}
        table.insert(registered[method], source.name)
      end
    end
    return registered
  end

  -- for formatter
  local list_registered = function(filetype)
    local method = null_ls.methods.FORMATTING
    local registered_providers = list_registered_providers_names(filetype)
    return registered_providers[method] or {}
  end

  --- for linter
  local alternative_methods = {
    null_ls.methods.DIAGNOSTICS,
    null_ls.methods.DIAGNOSTICS_ON_OPEN,
    null_ls.methods.DIAGNOSTICS_ON_SAVE,
  }

  local linter_list_registered = function(filetype)
    local registered_providers = list_registered_providers_names(filetype)
    local providers_for_methods = vim.tbl_flatten(vim.tbl_map(function(m)
      return registered_providers[m] or {}
    end, alternative_methods))

    return providers_for_methods
  end
  -- end for lsp

  local lsp_info = {
    function()
      --local msg = "No Active Lsp"
      local msg = "LS Inactive"
      -- local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
      local buf_ft = vim.bo.filetype
      -- start register
      local buf_clients = vim.lsp.buf_get_clients()
      local buf_client_names = {}
      if next(buf_clients) == nil then
        -- TODO: clean up this if statement
        if type(msg) == "boolean" or #msg == 0 then
          return "LS Inactive"
        end
        return msg
      end
      -- add client
      for _, client in pairs(buf_clients) do
        if client.name ~= "null-ls" and client.name ~= "copilot" then
          table.insert(buf_client_names, client.name)
        end
      end
      -- add formatter
      local supported_formatters = list_registered(buf_ft)
      vim.list_extend(buf_client_names, supported_formatters)
      -- add linter
      local supported_linters = linter_list_registered(buf_ft)
      vim.list_extend(buf_client_names, supported_linters)
      -- decomple
      local unique_client_names = vim.fn.uniq(buf_client_names)
      local msg = table.concat(unique_client_names, ", ")
      return msg
    end,
    icon = IL.gear,
  }

  local IS = icons.signs
  lualine.setup({
    options = {
      icons_enabled = true,
      theme = "auto",
      component_separators = { left = "", right = "" },
      section_separators = { left = "", right = "" },
      disabled_filetypes = {
        "TelescopePrompt",
        "Outline",
        "lazy",
        "mason",
      },
      always_divide_middle = true,
    },
    sections = {
      lualine_a = { 'filename' },
      lualine_b = { 'branch', 'diff' },
      lualine_c = {
        {
          'diagnostics',
          symbols = {
            error = IS.Error .. " ",
            warn = IS.Warn .. " ",
            hint = IS.Hint .. " ",
            info = IS.Info .. " ",
          },
          colored = true,
        }
      },
      lualine_x = {
        lsp_info,
        'fileformat',
        'encoding',
        'filetype',
      },
      lualine_y = { 'progress' },
      lualine_z = { progress },
    },
    sources = { 'nvim_diagnostic' },
  })
  vim.cmd("set laststatus=3")
end

return PLUG
