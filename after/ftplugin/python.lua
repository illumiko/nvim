-- vim.cmd[[TSEnable highlight]]
local x = require("user.keymaps")
vim.g.mapleader = " "
local opts = function(x)
	return { noremap = true, silent = true, desc = x, buffer = true }
end
vim.keymap.set("n", "<leader>P", ":!python3 %<cr>", opts("run current python file"))
