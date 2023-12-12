local PLUG = {
  "kdheepak/lazygit.nvim",
  lazy = true,
  keys = { "<leader>g", "<cmd>LazyGit<cr>" },
  event = { "BufReadPost", "BufNewFile", "VeryLazy" },
  cmd = "LazyGit",
}

function PLUG.config()
  vim.keymap.set("n", "<leader>g", "<cmd>LazyGit<cr>", {silent = true})
end

return PLUG
