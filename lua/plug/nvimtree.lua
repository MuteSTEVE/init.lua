local PLUG = {
  'nvim-tree/nvim-tree.lua',
  dependencies = 'kyazdani42/nvim-web-devicons',
  lazy = true,
  event = "VeryLazy",
  cmd = { "NvimTreeFindFile", "NvimTreeRefresh", "NvimTreeToggle", },
  keys = { "<leader>n", "<cmd>NvimTreeFindFileToggle<cr>" }
}

function PLUG.config()
  local nvimtree_ok, nvim_tree = pcall(require, "nvim-tree")
  if not nvimtree_ok then
    return
  end
  local icons_ok, icons = pcall(require, 'core.icons')
  if not icons_ok then
    return
  end
  local INVT = icons.nvimtree
  local IG = icons.git

  nvim_tree.setup {
    disable_netrw = true,
    hijack_netrw = true,
    git = {
      enable = true,
      ignore = true,
      timeout = 500,
    },
    view = {
      width = 30,
      side = "left",
      number = false,
      relativenumber = false,
    },
    renderer = {
      indent_markers = { enable = true },
      root_folder_modifier = ":t",
      highlight_git = true,
      icons = {
        show = {
          file = true,
          folder = true,
          folder_arrow = false,
          git = true,
        },
        glyphs = {
          default = INVT.GlyphDefault,
          symlink = INVT.GlyphSymlink,
          git = {
            unstaged = IG.unstaged,
            staged = IG.staged,
            unmerged = IG.unmerged,
            renamed = IG.renamed,
            deleted = IG.deleted,
            untracked = IG.untracked,
            ignored = IG.ignored,
          },
          folder = {
            default = INVT.default,
            open = INVT.open,
            empty = INVT.empty,
            empty_open = INVT.empty_open,
            symlink = INVT.symlink,
          },
        }
      }
    }
  }

  vim.keymap.set("n", "<leader>n", "<cmd>NvimTreeFindFileToggle<cr>", {silent = true})
end

return PLUG
