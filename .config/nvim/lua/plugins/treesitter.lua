local plugins = {
	{
		"nvim-treesitter/nvim-treesitter",
		opts = {
			ensure_installed = {
				-- defaults
				"vim",
				"lua",
				"vimdoc",

				--backend
				"go",
				"python",
				"php",

				-- web dev
				"html",
				"css",
				"javascript",
				"typescript",
				"tsx",
			},
			indent = {
				enable = true,
				-- disable = {
				--   "python"
				-- },
			},
		},
	},
}

return plugins
