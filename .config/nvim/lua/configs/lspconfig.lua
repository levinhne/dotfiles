local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

local util = require "lspconfig/util"

local servers = {
  jsonls = {},
  html = {},
  cssls = {},
  tailwindcss = {},

  -- go
  gopls = {
    cmd = { "gopls" },
    filetypes = { "go", "gomod", "gowork", "gotmpl", "tmpl" },
    root_dir = util.root_pattern("go.work", "go.mod", ".git"),
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
  },
  golangci_lint_ls = {},
  bufls = {},

  jdtls = {},
  -- javascript/typesctipt
  tsserver = {},
  denols = {},
  eslint = {},

  --php
  intelephense = {
    filetypes = { "php" },
  },

  -- python
  pyright = {
    filetypes = { "python" },
  },

  -- helm
  helm_ls = {
    yamlls = {
      path = "yaml-language-server",
    },
  },

  yamlls = {},

  -- docker
  dockerls = {},

  -- lua
  lua_ls = {
    cmd = { "lua-language-server" },
    filetypes = { "lua" },
  },
}


for name, opts in pairs(servers) do
  opts.on_init = on_init
  opts.on_attach = on_attach
  opts.capabilities = capabilities
  require("lspconfig")[name].setup(opts)
end
