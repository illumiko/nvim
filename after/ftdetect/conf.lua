local g = vim.api.nvim_create_augroup("cf", { clear = true })
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
	group = g,
	pattern = "*.conf",
	callback = function()
		vim.cmd("set filetype=hyprlang")
        vim.cmd("hi i3ConfigError guibg=none")
	end,
})

