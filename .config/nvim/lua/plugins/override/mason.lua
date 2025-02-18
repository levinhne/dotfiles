local plugins = {
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    opts = {
      ensure_installed = {
        -- lua
        "lua_ls",
        -- go
        "gopls",
        "golangci_lint_ls",
        -- protobuf
        -- "bufls",
        -- python
        "pyright",
        -- javascript/typescript
        "tsserver",
        "eslint",
        "denols",
        "jsonls",
        -- html/css
        "html",
        "cssls",
        "tailwindcss",
        -- devops
        "yamlls",
      },
      automatic_installation = true,
    },
  },
}

return plugins
