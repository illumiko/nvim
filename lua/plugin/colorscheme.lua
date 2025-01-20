local config = {}

config.kanagawa = function()
	require("kanagawa").setup({
		undercurl = true, -- enable undercurls
		commentStyle = { italic = false },
		functionStyle = { italic = false },
		keywordStyle = { bold = true },
		statementStyle = { bold = true },
		typeStyle = { bold = true, italic = false },
		variablebuiltinStyle = {},
		specialReturn = true, -- special highlight for the return keyword
		specialException = true, -- special highlight for exception handling keywords
		transparent = true, -- do not set background color
		dimInactive = true, -- dim inactive window `:h hl-NormalNC`
		globalStatus = true,
	})
	vim.cmd([=[
colorscheme kanagawa
hi link CmpPmenu Normal
]=])
end

config.gruvbox = function()
	require("gruvbox").setup({
		undercurl = true,
		underline = true,
		bold = true,
		-- italic = true,
		strikethrough = true,
		invert_selection = false,
		invert_signs = false,
		invert_tabline = false,
		invert_intend_guides = true,
		inverse = false, -- invert background for search, diffs, statuslines and errors
		contrast = "soft", -- can be "hard", "soft" or empty string
		palette_overrides = {},
		overrides = {},
		dim_inactive = true,
		transparent_mode = false,
	})
	vim.cmd([=[
hi IndentBlanklineChar guifg=none
hi TreesitterContext guibg=#222222
]=])
end

local plugins = {
	{ "ellisonleao/gruvbox.nvim", lazy = true, config = config.gruvbox },
	{ "rockyzhang24/arctic.nvim", branch = "v2" },
	{ "rebelot/kanagawa.nvim", lazy = true, config = config.kanagawa }, 
}

return plugins
