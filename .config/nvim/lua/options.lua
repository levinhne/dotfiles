require "nvchad.options"

-- add yours here!

-- local o = vim.o
-- o.cursorlineopt ='both' -- to enable cursorline!
local g = {}

local opts = {
  relativenumber = true,
  mouse = "v",
  swapfile = false,
}

for k, v in pairs(g) do
  vim.g[k] = v
end

for k, v in pairs(opts) do
  vim.opt[k] = v
end

vim.api.nvim_create_autocmd("TermOpen", {
  callback = function()
    local win = vim.api.nvim_get_current_win()
    vim.wo[win].foldcolumn = "0"
    vim.wo[win].signcolumn = "no"
  end,
})
