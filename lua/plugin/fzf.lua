return {
	"ibhagwan/fzf-lua",
	-- optional for icon support
	dependencies = { "nvim-tree/nvim-web-devicons" },
	-- lazy = true,
	keys = {
		{
			"<leader>fn",
			function()
				require("fzf-lua").files({ cwd = "$HOME/dotfiles/nvim" })
			end,
			desc = "help menu picker",
		},
		{
			"<leader>fh",
			function()
				require("fzf-lua").helptags()
			end,
			desc = "help menu picker",
		},
		{
			"<leader>fp",
			function()
				require("fzf-lua").files({ cwd = "~/Documents/Projects/" })
			end,
			desc = "Project Files",
		},
		{
			"<leader>fd",
			function()
				require("fzf-lua").files({ cwd = "~/dotfiles/" })
			end,
			desc = "Config Files",
		},
		{
			"<leader>B",
			function()
				require("fzf-lua").buffers()
			end,
			desc = "Buffers",
		},
		{
			"<leader>ff",
			function()
				require("fzf-lua").files()
			end,
			desc = "Find Files",
		},
		{
			"<leader>fr",
			function()
				require("fzf-lua").oldfiles()
			end,
			desc = "Old Files",
		},
		{
			"<leader>ht",
			function()
				require("fzf-lua").colorschemes()
			end,
			desc = "Colorschemes",
		},
		{
			"<leader>fg",
			function()
				require("fzf-lua").live_grep()
			end,
			desc = "Grep Directory",
		},
		{
			"<S-Tab>",
			function()
				require("fzf-lua").buffers()
			end,
			desc = "Buffer Picker",
		},
	},
	-- ... rest of your config
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
					["ctrl-q"] = "abort",
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
