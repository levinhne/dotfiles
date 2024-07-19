local plugins = {
  {
    "github/copilot.vim",
    -- event = "BufEnter",
    config = function()
      vim.g.copilot_filetypes = {
        html = false,
      }
      vim.g.copilot_assume_mapped = true
      vim.g.copilot_no_tab_map = true
      vim.g.copilot_enabled = false

      local map = vim.keymap.set

      map("i", "<C-CR>", 'copilot#Accept("\\<CR>")', { expr = true, replace_keycodes = false })
      map("i", "<C-L>", "<Plug>(copilot-accept-word)")
    end,
  },
}

return plugins
