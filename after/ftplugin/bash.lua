local function run_without()
local file = vim.fn.expand("%p")
vim.cmd("silent write")

local compile = string.format("bash %s",file)
vim.cmd("belowright split | terminal " .. compile)
local buf = vim.api.nvim_get_current_buf()
vim.api.nvim_set_option_value("buflisted",false,{buf=buf})
	vim.keymap.set("n", "q", function()
		vim.cmd("bdelete!")
	end, { buffer = buf, desc = "Close terminal" })

end
vim.keymap.set("n", "<leader>p1", run_without, { desc="run without input file",noremap = true, silent = true, buffer = true })
