require("nvchad.configs.lspconfig").defaults()
local util = require "lspconfig/util"

local servers = {
  "lua_ls",
  -- go
  "gopls",
  "golangci_lint_ls",
  -- ts
  "ts_ls",
  -- python
  "pyright",

  "html",
  "cssls",
  "jsonls",
  "tailwindcss",
}

vim.lsp.config("gopls", {
  cmd = { "gopls" },
  filetypes = { "go", "gomod", "gowork", "gotmpl", "tmpl" },
  root_dir = util.root_pattern("go.work", "go.mod"),
  settings = {
    gopls = {
      buildFlags = { "-tags=wireinject" },
      completeUnimported = true,
      usePlaceholders = true,
      analyses = {
        unusedparams = true,
      },
    },
  },
})

vim.lsp.enable(servers)

-- read :h vim.lsp.config for changing options of lsp servers
