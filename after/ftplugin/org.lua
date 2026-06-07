local nmap = require("utils.maps").nmap
local opts = { buffer = 0, noremap = true, silent = true }
local g = vim.api.nvim_create_augroup("ngo", { clear = true })
-- vim.cmd([[set statusline=%{v:lua.orgmode.statusline()}]])
vim.api.nvim_create_autocmd({ "BufEnter" }, { -- {{{
	pattern = { "*.org" },
	group = g,
	callback = function()
		nmap("<leader>2", function()
			local path, year, week = "~/Documents/org/journal/weeks/", os.date("%Y"),os.date("%U")
			local prefix, suffix = ":e ", "<CR>"
			local file = path .. year .."-".. "W".. week .. ".org"
			local full_cmd = prefix .. file .. suffix
			print(full_cmd)
			return full_cmd
		end, { buffer = 0, expr = true, noremap = true, silent = true })
		nmap("<leader>1", function()
			local path, date = "~/Documents/org/journal/", os.date("%Y-%m-%d")
			local prefix, suffix = ":e ", "<CR>"
			local file = path .. date .. ".org"
			local full_cmd = prefix .. file .. suffix
			print(full_cmd)
			return full_cmd
		end, { buffer = 0, expr = true, noremap = true, silent = true })
		--vim.cmd("colorscheme tokyonight")
	end,
}) -- }}}
    
