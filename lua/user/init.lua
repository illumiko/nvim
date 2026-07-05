require("user.keymaps")
require("user.settings")
require("user.autocmds")

-- require'rose-pine'.setup({styles={transparency = true}})
-- vim.cmd("colorscheme rose-pine-moon") --giving windline sane colors with nordic
-- vim.cmd("colorscheme rose-pine-dawn") --giving windline sane colors with nordic
-- vim.cmd("set background=light")
-- vim.cmd("colorscheme onenord")
-- vim.cmd("colorscheme arctic")
vim.o.background = 'dark'
require("solarized").setup({
	styles = {
		enabled = true,
		types = { bold = true },
		functions = {},
		parameters = { italic = true },
		comments = {},
		strings = {},
		keywords = {italic = true},
		variables = {},
		constants = {bold = true,italic=true},
	},
})
vim.cmd.colorscheme("solarized")

require("user.highlights")
