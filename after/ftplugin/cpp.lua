-- Function to compile and run the current C++ file
local function compile_and_run_cpp()
	-- Save the current file
	vim.cmd("silent w")

	-- Get the full path and base name of the current file
	local filename = vim.fn.expand("%:p")
	local basename = vim.fn.expand("%:r")

	-- Define the compile and run command (adjust flags as needed)
	local compile_cmd = string.format('g++ -std=c++17 "%s" && ./a.out', filename)
	-- local compile_cmd = string.format([[g++ -std=c++17 %s]], filename)
	-- local compile_cmd = string.format('g++ -std=c++17 "%s" -o "%s" && "%s"', filename, basename, basename)

	-- Execute the command in a built-in terminal split
	vim.cmd("belowright split | terminal " .. compile_cmd)
	local buf = vim.api.nvim_get_current_buf()

	-- Remove from tabbar
	vim.api.nvim_buf_set_option(buf, "buflisted", false)

	-- Close on q
	vim.keymap.set("n", "q", function()
		vim.cmd("bdelete!")
	end, { buffer = buf, desc = "Close terminal" })
	-- Optionally, set the terminal to insert mode so you can interact with the program
	vim.cmd("startinsert")
end

-- Map the function to a key, e.g., <F5>
vim.keymap.set("n", "P", compile_and_run_cpp, { noremap = true, silent = true, buffer = true })
