local function open_float(filename)
	-- create an unlisted, scratch buffer
	-- local buf = vim.api.nvim_create_buf(false, true)
	local buf = vim.fn.bufadd(filename)
	vim.fn.bufload(buf)

	vim.bo[buf].bufhidden = "wipe"
	vim.bo[buf].filetype = "myfloat"

	local width = 40
	local height = 10
	local ui = vim.api.nvim_list_uis()[1]

	local win = vim.api.nvim_open_win(buf, true, {
		relative = "editor",
		width = width,
		height = height,
		row = math.floor((ui.height - height) / 2),
		col = math.floor((ui.width - width) / 2),
		style = "minimal",
		border = "rounded",
		title = " My Menu ",
		title_pos = "center",
	})

	-- close on q or <Esc>
	vim.keymap.set("n", "q", "<cmd>close<CR>", { buffer = buf, nowait = true })
	vim.keymap.set("n", "<Esc>", "<cmd>close<CR>", { buffer = buf, nowait = true })

	return buf, win
end
function h()
	vim.ui.select({ "run from ar.t", "just run" }, { "Prompt: " }, function(choice, idx)
		local file = vim.fn.expand("%:p") --returns filepath of current file
		local out = vim.fn.expand("%:p:r") --returns filepath of current file without extention
		vim.cmd("silent write")
		if idx == 2 then
            print("")
		elseif idx == 1 then
            print("")
		end
	end)
end
function run_with()
	local file = vim.fn.expand("%:p") --returns filepath of current file
	local out = vim.fn.expand("%:p:r") --returns filepath of current file without extention
	vim.cmd("silent write")
	local input_file = vim.fn.expand("%:p:h") .. "/ar.t"
	local run_cmd
	if vim.fn.filereadable(input_file) == 1 then
		run_cmd = string.format('./a.out < "%s"', input_file)

		local compile_cmd = string.format('g++ -std=c++17 "%s" && %s', file, run_cmd)
		vim.cmd("belowright split | terminal " .. compile_cmd)
		-- vim.cmd("split | terminal gcc " .. file .. " -o " .. out .. " && " .. run_cmd)
		-- Remove from tabbar
		local buf = vim.api.nvim_get_current_buf()
		vim.api.nvim_buf_set_option(buf, "buflisted", false)
		-- Close on q
		vim.keymap.set("n", "q", function()
			vim.cmd("bdelete!")
		end, { buffer = buf, desc = "Close terminal" })
	else
		open_float(input_file)
	end
end
function run_without()
	local file = vim.fn.expand("%:p") --returns filepath of current file
	local out = vim.fn.expand("%:p:r") --returns filepath of current file without extention
	vim.cmd("silent write")
	run_cmd = "./a.out"
	local compile_cmd = string.format('g++ -std=c++17 "%s" && %s', file, run_cmd)
	vim.cmd("belowright split | terminal " .. compile_cmd)
	-- vim.cmd("split | terminal gcc " .. file .. " -o " .. out .. " && " .. out)
	-- Remove from tabbar
	local buf = vim.api.nvim_get_current_buf()
	vim.api.nvim_buf_set_option(buf, "buflisted", false)
	-- Close on q
	vim.keymap.set("n", "q", function()
		vim.cmd("bdelete!")
	end, { buffer = buf, desc = "Close terminal" })
end

vim.keymap.set("n", "<leader>p1", run_without, { desc="run without input file",noremap = true, silent = true, buffer = true })
vim.keymap.set("n", "<leader>p2", run_with, { desc="run with input file",noremap = true, silent = true,    buffer = true })
-- -- Function to compile and run the current C++ file
-- local function compile_and_run_cpp()
-- 	-- Save the current file
-- 	vim.cmd("silent w")
--
-- 	-- Get the full path and base name of the current file
-- 	local filename = vim.fn.expand("%:p")
-- 	local basename = vim.fn.expand("%:r")
--
-- 	-- Define the compile and run command (adjust flags as needed)
-- 	local compile_cmd = string.format('g++ -std=c++17 "%s" && ./a.out', filename)
-- 	-- local compile_cmd = string.format([[g++ -std=c++17 %s]], filename)
-- 	-- local compile_cmd = string.format('g++ -std=c++17 "%s" -o "%s" && "%s"', filename, basename, basename)
--
-- 	-- Execute the command in a built-in terminal split
-- 	vim.cmd("belowright split | terminal " .. compile_cmd)
-- 	local buf = vim.api.nvim_get_current_buf()
--
-- 	-- Remove from tabbar
-- 	vim.api.nvim_buf_set_option(buf, "buflisted", false)
--
-- 	-- Close on q
-- 	vim.keymap.set("n", "q", function()
-- 		vim.cmd("bdelete!")
-- 	end, { buffer = buf, desc = "Close terminal" })
-- 	-- Optionally, set the terminal to insert mode so you can interact with the program
-- 	-- vim.cmd("startinsert")
-- end

-- local function compile_and_run_cpp()
-- 	-- Save the current file
-- 	vim.cmd("silent w")
-- 	-- Get the full path and base name of the current file
-- 	local filename = vim.fn.expand("%:p")
-- 	local basename = vim.fn.expand("%:r")
-- 	local dirname = vim.fn.expand("%:p:h")
--
-- 	-- Check for ar.t next to the source file
-- 	local input_file = dirname .. "/ar.t"
-- 	local run_cmd
-- 	if vim.fn.filereadable(input_file) == 1 then
-- 		run_cmd = string.format('./a.out < "%s"', input_file)
-- 	else
-- 		run_cmd = "./a.out"
-- 	end
--
-- 	-- Define the compile and run command (adjust flags as needed)
-- 	local compile_cmd = string.format('g++ -std=c++17 "%s" && %s', filename, run_cmd)
-- 	-- local compile_cmd = string.format([[g++ -std=c++17 %s]], filename)
-- 	-- local compile_cmd = string.format('g++ -std=c++17 "%s" -o "%s" && "%s"', filename, basename, basename)
-- 	-- Execute the command in a built-in terminal split
-- 	vim.cmd("belowright split | terminal " .. compile_cmd)
-- 	local buf = vim.api.nvim_get_current_buf()
-- 	-- Remove from tabbar
-- 	vim.api.nvim_buf_set_option(buf, "buflisted", false)
-- 	-- Close on q
-- 	vim.keymap.set("n", "q", function()
-- 		vim.cmd("bdelete!")
-- 	end, { buffer = buf, desc = "Close terminal" })
-- 	-- Optionally, set the terminal to insert mode so you can interact with the program
-- 	-- vim.cmd("startinsert")
-- end
-- -- Map the function to a key, e.g., <F5>
-- vim.keymap.set("n", "P", compile_and_run_cpp, { noremap = true, silent = true, buffer = true })

