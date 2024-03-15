local plugins = {
	{
		"williamboman/mason.nvim",
		opts = {
			ensure_installed = {
				-- lua
				"lua-language-server",
				"stylua",

				-- go
				"gopls",

				-- python
				"black",
				"debugpy",
				"mypy",
				"ruff",
				"pyright",

				-- javascript
				"eslint-lsp",
				"js-debug-adapter",
				"prettier",
				"typescript-language-server",
			},
		},
	},
}

return plugins
