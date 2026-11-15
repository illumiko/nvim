return {
	"vyfor/cord.nvim",
	---@type CordConfig
	opts = {
		-- ...
	},
	config = function()
		require("cord").setup({
			advanced = {
				server = {
					timeout = 2000, -- 5 seconds
				},
			},

			extensions = {
				visibility = {
					override = true, -- Whether the extension overrides activity updates directly
					precedence = "blacklist", -- 'blacklist' or 'whitelist' to resolve conflicts
					resolve_symlinks = true, -- Resolve symlinks when matching paths
					rules = {
						blacklist = {
							"**/dotfiles/**",
							{ type = "path", value = "dotfiles/**" },
							{ type = "path", value = "$HOME/dotfiles/nvim/**" },
							"secret", -- Matches a workspace name
							"~/work/private", -- Matches a specific directory path
							{ type = "glob", value = "**/dotfiles/**" }, -- Matches a glob pattern
						},
					},
				},
			},
		})
	end,
}
