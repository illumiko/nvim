local M = {}
M.config = {}
M.lazy = {}


M.config = {
    plugins = {
        presets = {
            operators = false
        }
    }
	-- your configuration comes here
	-- or leave it empty to use the default settings
	-- refer to the configuration section below
}
M.lazy = {
	"folke/which-key.nvim",
    config = M.config
}
return M.lazy
