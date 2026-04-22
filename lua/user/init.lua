require("user.keymaps")
require("user.settings")
require("user.autocmds")


require'rose-pine'.setup({styles={transparency = true}})
vim.cmd("colorscheme rose-pine-moon") --giving windline sane colors with nordic
-- vim.cmd("colorscheme nordic")
-- vim.cmd("colorscheme arctic")

require("user.highlights")
