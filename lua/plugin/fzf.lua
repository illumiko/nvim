return {
	"ibhagwan/fzf-lua",
	-- optional for icon support
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local actions = require("fzf-lua.actions")
		require("fzf-lua").setup({
			"ivy",
			actions = {
				files = {
					-- instead of the default action 'actions.file_edit_or_qf'
					-- it's important to define all other actions here as this
					-- table does not get merged with the global defaults
					["default"] = actions.file_edit,
					["ctrl-s"] = actions.file_split,
					["ctrl-v"] = actions.file_vsplit,
					["ctrl-t"] = actions.file_tabedit,
					["ctrl-q"] = actions.file_sel_to_qf,
					-- ["q"] = actions.close,
				},
			},
			keymap = {
				fzf = {
					true,
					["ctrl-w"] = "abort",
					["alt-j"] = "down",
					["alt-k"] = "up",
				},
			},
		})
	end,
	-- or if using mini.icons/mini.nvim
	-- dependencies = { "nvim-mini/mini.icons" },
	---@module "fzf-lua"
	---@type fzf-lua.Config|{}
	---@diagnostic disable: missing-fields
	opts = {},
	---@diagnostic enable: missing-fields
}
