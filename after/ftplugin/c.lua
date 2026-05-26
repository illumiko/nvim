if vim.bo.filetype == "c" then
	vim.keymap.set("n", "<leader>P", function()
		local file = vim.fn.expand("%:p")
		local out = vim.fn.expand("%:p:r")
		vim.cmd("write")

		vim.cmd("split | terminal gcc " .. file .. " -o " .. out .. " && " .. out)
		-- Remove from tabbar

		local buf = vim.api.nvim_get_current_buf()
		vim.api.nvim_buf_set_option(buf, "buflisted", false)

		-- Close on q
		vim.keymap.set("n", "q", function()
			vim.cmd("bdelete!")
		end, { buffer = buf, desc = "Close terminal" })
	end, { desc = "Compile and run C file", noremap = true, buffer = true })
end
