local configs = require "nvchad.configs.lspconfig"

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
  opts.on_init = configs.on_init
  opts.on_attach = configs.on_attach
  opts.capabilities = configs.capabilities

  require("lspconfig")[name].setup(opts)
end
