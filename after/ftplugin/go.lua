-- vim.cmd([[TSEnable highlight]])

vim.g.mapleader = " "
local opts = function(x)
	return { noremap = true, silent = true, desc = x, buffer = true }
end
vim.keymap.set("n", "<leader>P", ":!go run %<cr>", opts("run current go file"))
