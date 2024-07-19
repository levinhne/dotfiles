require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

vim.opt.mouse = ""

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

-- map({ "n", "i", "v" }, "<leader>gg", "<cmd>LazyGit<cr>", { desc = "lazygit" })

map("n", "<leader>lr", "<cmd>LspRestart<cr>", { desc = "lsp restart" })
