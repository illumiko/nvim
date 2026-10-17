local config = {}
config.kanagawa = function()
	require("kanagawa").setup({
		undercurl = true, -- enable undercurls
		commentStyle = { italic = true },
		functionStyle = { italic = true },
		keywordStyle = { bold = true },
		statementStyle = { bold = true },
		typeStyle = { bold = true, italic = false },
		variablebuiltinStyle = {},
		specialReturn = true, -- special highlight for the return keyword
		specialException = true, -- special highlight for exception handling keywords
		transparent = false, -- do not set background color
		dimInactive = true, -- dim inactive window `:h hl-NormalNC`
		globalStatus = true,
	})
	vim.cmd([=[
hi link CmpPmenu Normal
]=])
end

config.gruvbox = function()
	vim.cmd([=[
    let g:gruvbox_material_background = "soft"
    let g:gruvbox_material_foreground = "original"
    let g:gruvbox_material_cursor = "red"
    let g:gruvbox_material_dim_inactive_window = 1
"hi IndentBlanklineChar guifg=none
"hi TreesitterContext guibg=#222222
]=])
end

config.zenbones = function() end

local plugins = {
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		opts = {},
	},
	{ "sainnhe/gruvbox-material" },
	{ "rockyzhang24/arctic.nvim", branch = "v2" }, --vscode theme pretty good
	{ "olimorris/onedarkpro.nvim", priority = 1000 },
	{ "rebelot/kanagawa.nvim", lazy = false, config = config.kanagawa },
	{ "zenbones-theme/zenbones.nvim" },
	{ "kdheepak/monochrome.nvim" },
	{ "rktjmp/lush.nvim" },
	{ "AlexvZyl/nordic.nvim" },
	{ "rose-pine/neovim", name = "rose-pine" },
	{ "rmehri01/onenord.nvim", config = false },
	-- {
	-- 	"masisz/wisteria.nvim",
	-- 	name = "wisteria",
	-- 	opts = {
	-- 		style = "dark", -- "dark" or "light"
	-- 		transparent = true,
	-- 		---@type fun(colors:WisteriaColors):HighlightSpec
	-- 		overrides = function(colors)
	-- 			return {}
	-- 		end,
	-- 	},
	-- },
	{
		"maxmx03/solarized.nvim",
		config = function()
			require("solarized").setup({
				transparent = {
					enabled = false, -- Master switch to enable transparency
					pmenu = false, -- Popup menu (e.g., autocomplete suggestions)
					normal = true, -- Main editor window background
					normalfloat = false, -- Floating windows
					neotree = true, -- Neo-tree file explorer
					nvimtree = true, -- Nvim-tree file explorer
					whichkey = false, -- Which-key popup
					telescope = false, -- Telescope fuzzy finder
					lazy = false, -- Lazy plugin manager UI
					mason = false, -- Mason manage external tooling
				},
			})
		end,
	},
	{ "edeneast/nightfox.nvim" },
	{
		"silentium-theme/silentium.nvim",
	},
}

return plugins
