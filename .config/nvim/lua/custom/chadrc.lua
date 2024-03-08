---@type ChadrcConfig
local M = {}

M.ui = {
	theme = "github_dark",
	transparency = true,
	telescope = {
		style = "bordered",
	},
	statusline = {
		theme = "minimal",
	},
}
M.plugins = "custom.plugins"
M.mappings = require("custom.mappings")

return M
