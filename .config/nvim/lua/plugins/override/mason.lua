local plugins = {
  {
    "williamboman/mason.nvim",
    cmd = { "Mason", "MasonInstall", "MasonInstallAll", "MasonUpdate" },
    opts = {
      PATH = "skip",
      ui = {
        icons = {
          package_pending = " ",
          package_installed = " ",
          package_uninstalled = " ",
        },
      },

      max_concurrent_installers = 10,
      ensure_installed = {
        -- lua
        "lua-language-server",
        "stylua",

        -- go
        "gopls",
        "golangci-lint-langserver",
        -- protobuf
        "buf-language-server",

        -- python
        "black",
        "debugpy",
        "mypy",
        "ruff",
        "pyright",

        -- php
        -- "intelephense",

        -- javascript
        "deno",
        "eslint-lsp",
        "js-debug-adapter",
        "prettier",
        "typescript-language-server",
        "json-lsp",

        -- html
        "html-lsp",
        -- css
        "css-lsp",
        "tailwindcss-language-server",

        -- devops
        -- "helm-ls",
        -- "dockerfile-language-server",
        "yaml-language-server",
      },
    },
  },
}

return plugins
