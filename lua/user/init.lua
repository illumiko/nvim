require("user.keymaps")
require("user.settings")
require("user.autocmds")

-- require'rose-pine'.setup({styles={transparency = true}})
-- vim.cmd("colorscheme rose-pine-moon") --giving windline sane colors with nordic
-- vim.cmd("colorscheme rose-pine-dawn") --giving windline sane colors with nordic
-- vim.cmd("set background=light")
-- vim.cmd("colorscheme nordic")

vim.cmd("set background=light")
vim.cmd("colorscheme zenbones")
-- local silentium = require("silentium")
-- local accents = vim.tbl_keys(silentium.accents)
-- local random_accent = accents[math.random(#accents)]
--
-- silentium.setup({
--   accent = silentium.accents[random_accent]
-- })
-- vim.cmd("colorscheme silentium");
-- vim.cmd("colorscheme arctic")
-- vim.o.background = 'light'
-- 	vim.cmd([=[
--     let g:gruvbox_material_background = "hard"
--     let g:gruvbox_material_foreground = "original"
--     let g:gruvbox_material_cursor = "blue"
--     let g:gruvbox_material_dim_inactive_window = 1
--     colorscheme gruvbox-material
-- ]=])
-- require("solarized").setup({
-- 	styles = {
-- 		enabled = true,
-- 		types = { bold = true },
-- 		functions = {},
-- 		parameters = { italic = true },
-- 		comments = {},
-- 		strings = {},
-- 		keywords = {italic = true},
-- 		variables = {},
-- 		constants = {bold = true,italic=true},
-- 	},
-- })
-- vim.cmd.colorscheme("solarized")
-- vim.cmd([[
-- hi TelescopeSelection guibg=#514b49
-- ]])
-- vim.cmd.colorscheme("gruvbox")

require("user.highlights")
