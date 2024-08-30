require "nvchad.mappings"

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

vim.opt.mouse = ""

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

-- map({ "n", "i", "v" }, "<leader>gg", "<cmd>LazyGit<cr>", { desc = "lazygit" })

map("n", "<leader>lr", "<cmd>LspRestart<cr>", { desc = "lsp restart" })

map("i", "<C-CR>", 'copilot#Accept("\\<CR>")', { expr = true, replace_keycodes = false })
map("i", "<C-L>", "<Plug>(copilot-accept-word)")

map("n", "<leader>kr", ":lua require('kulala').run()<CR>", { noremap = true, silent = true })

