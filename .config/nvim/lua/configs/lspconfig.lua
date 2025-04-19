local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

local util = require "lspconfig/util"

local servers = {
  -- go
  gopls = {
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
  },
  golangci_lint_ls = {},

  jdtls = {},
  -- javascript/typesctipt
  ts_ls = {
    root_dir = util.root_pattern("package.json", "tsconfig.json"),
  },
  denols = {
    root_dir = util.root_pattern("deno.json", "deno.jsonc"),
  },
  eslint = {},

  --php
  -- intelephense = {
  --   filetypes = { "php" },
  -- },

  -- python
  pyright = {
    filetypes = { "python" },
  },

  -- helm
  -- helm_ls = {
  --   yamlls = {
  --     path = "yaml-language-server",
  --   },
  -- },

  yamlls = {},

  -- docker
  dockerls = {},

  -- lua
  lua_ls = {
    cmd = { "lua-language-server" },
    filetypes = { "lua" },
  },

  jsonls = {},
  html = {},
  cssls = {},
  tailwindcss = {
    root_dir = util.root_pattern("tailwind.config.js", "tailwind.config.cjs"),
  },
}

for name, opts in pairs(servers) do
  opts.on_init = on_init
  opts.on_attach = on_attach
  opts.capabilities = capabilities
  require("lspconfig")[name].setup(opts)
end
