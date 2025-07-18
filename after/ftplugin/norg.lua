local nmap = require("utils.maps").nmap
local opts = { buffer = 0, noremap = true, silent = true }
local g = vim.api.nvim_create_augroup("ng", { clear = true })
-- {{{ Settings
vim.opt.foldlevel = 0
vim.opt.spell = true
vim.cmd([[
setlocal spell
set conceallevel=3
set spelllang=nl,en_gb
inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u
]])

-- }}}
-- {{{ keybinds

-- only adds M-1... keybinds to norg ft
vim.api.nvim_create_autocmd({ "BufEnter" }, { -- {{{
	pattern = { "*.norg" },
	group = g,
	callback = function()
		nmap("<leader>1", ":e ~/Documents/norg/index.norg<CR>", opts)
		nmap("<leader>2", ":e ~/Documents/norg/inbox.norg<CR>", opts)
		nmap("<leader>3", function()
			local path, date = "~/Documents/norg/journal/", os.date("%Y-%m-%d")
			local prefix, suffix = ":e ", "<CR>"
			local file = path .. date .. ".norg"
			local full_cmd = prefix .. file .. suffix
			print(full_cmd)
			return full_cmd
		end, { buffer = 0, expr = true, noremap = true, silent = true })
		--vim.cmd("colorscheme tokyonight")
	end,
}) -- }}}

--[[ vim.api.nvim_create_autocmd({ "BufWinEnter" }, { -- {{{
	pattern = { "*.norg" },
	group = g,
	callback = function()
        vim.cmd("UfoDisable")
	end,
}) -- }}} ]]
-- }}}
