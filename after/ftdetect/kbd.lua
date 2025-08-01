local g = vim.api.nvim_create_augroup("kbd", { clear = true })
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
	group = g,
	pattern = "*.kbd",
	callback = function()
		vim.cmd("set filetype=lisp")
        vim.cmd("hi i3ConfigError guibg=none")
	end,
})
