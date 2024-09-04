local plugins = {
  {
    "Exafunction/codeium.vim",
    -- event = "BufEnter",
    config = function()
      vim.g.codeium_no_map_tab = true
      vim.g.codeium_enabled = true
      vim.g.codeium_disable_bindings = 1
      local map = vim.keymap.set

      map("i", "<C-CR>", function()
        return vim.fn["codeium#Accept"]()
      end, { expr = true, silent = true })
      map("i", "<C-J>", function()
        return vim.fn["codeium#Accept"]()
      end, { expr = true, silent = true })
    end,
  },
}

return plugins
