local enable = false
local M = {}
local config = {}
M.lazy = {
	"glepnir/dashboard-nvim",
	event = "VimEnter",
	config = true,
}

if enable == true then
	return M.lazy
else
	return {}
end
