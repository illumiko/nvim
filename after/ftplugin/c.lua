if vim.bo.filetype == "c" then
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
	local function run_without()
		local file = vim.fn.expand("%:p") --returns filepath of current file
		local out = vim.fn.expand("%:p:r") --returns filepath of current file without extention
		vim.cmd("silent write")
		vim.cmd("split | terminal gcc " .. file .. " -o " .. out .. " && " .. out)
		-- Remove from tabbar
		local buf = vim.api.nvim_get_current_buf()
		vim.api.nvim_buf_set_option(buf, "buflisted", false)
		-- Close on q
		vim.keymap.set("n", "q", function()
			vim.cmd("bdelete!")
		end, { buffer = buf, desc = "Close terminal" })
	end
	local function run_with()
		local file = vim.fn.expand("%:p") --returns filepath of current file
		local out = vim.fn.expand("%:p:r") --returns filepath of current file without extention
		vim.cmd("silent write")
		local input_file = vim.fn.expand("%:p:h") .. "/ar.t"
		local run_cmd
		if vim.fn.filereadable(input_file) == 1 then
			run_cmd = out .. " < " .. input_file

			vim.cmd("split | terminal gcc " .. file .. " -o " .. out .. " && " .. run_cmd)
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
	vim.keymap.set("n", "<leader>p1", run_without, { desc = "Compile and run C file", noremap = true, buffer = true })
	vim.keymap.set("n", "<leader>p2", run_with, { desc = "Compile and run C file with input file", noremap = true, buffer = true })
end
