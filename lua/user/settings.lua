vim.o.backup = false -- creates a backup file
-- vim.opt.clipboard = "unnamedplus" -- allows neovim to access the system clipboard
vim.o.cmdheight = 0 -- more space in the neovim command line for displaying messages
vim.o.winborder = "solid"
vim.opt.colorcolumn = "100" -- fixes indentline for now
vim.o.conceallevel = 0 -- so that `` is visible in markdown files
vim.o.hidden = true -- required to keep multiple buffers and open multiple buffers
vim.o.ignorecase = true -- ignore case in search patterns
vim.o.pumheight = 15 -- pop up menu height
vim.o.showmode = true -- we don't need to see things like -- INSERT -- anymore
vim.o.signcolumn = "yes"
vim.opt.completefunc = "v:lua.require'omnicomp'" -- custom snippet completion defined in lua/snipcomp.lua
-- vim.o.showtabline = 2 -- always show tabs
vim.o.smartcase = true -- smart case
vim.o.smartindent = true -- make indenting smarter again
vim.o.splitbelow = true -- force all horizontal splits to go below current window
vim.o.splitright = true -- force all vertical splits to go to the right of current window
-- vim.o.swapfile = false -- creates a swapfile
vim.o.termguicolors = true -- set term gui colors (most terminals support this)
vim.o.timeoutlen = 100 -- time to wait for a mapped sequence to complete (in milliseconds)
-- vim.o.title = true -- set the title of window to the value of the titlestring
vim.o.undodir = vim.fn.stdpath("cache") .. "/undo"
vim.o.undofile = true -- enable persistent undo
vim.o.updatetime = 300 -- faster completion
vim.o.writebackup = false -- if a file is being edited by another program (or was written to file while editing with another program) it is not allowed to be edited
vim.o.expandtab = true -- convert tabs to spaces
vim.o.shiftwidth = 4 -- the number of spaces inserted for each indentation
vim.o.tabstop = 4 -- insert 1 spaces for a tab
vim.o.smarttab = true
vim.o.cursorline = false -- highlight the current line
vim.o.numberwidth = 4 -- set number column width to 2 {default 4}
vim.o.wrap = false -- display lines as one long line
vim.o.spell = false
vim.o.spelllang = "en"
vim.o.scrolloff = 4 -- use this with zz(centers view)
vim.o.sidescrolloff = 0
vim.o.softtabstop = 4
vim.o.laststatus = 3
vim.o.number = true
vim.o.relativenumber = true
vim.o.breakindent = true
-- vim.cmd("set shortmess+=cCFAI")
-- vim.o.wh = 20
-- vim.o.wiw = 100
-- vim.o.showbreak = string.rep(" ", 3)
-- Make it so that long lines wrap smartly

vim.o.linebreak = true
vim.opt.fillchars:append({
	horiz = "━",
	horizup = "┻",
	horizdown = "┳",
	vert = "┃",
	vertleft = "┨",
	vertright = "┣",
	verthoriz = "╋",
})
vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
vim.cmd([[
command Journal source ~/Documents/norg/sessions/vp.vim
]])
-- vim.opt.foldcolumn = "1"
vim.cmd([[
set noshowcmd noruler
]])
vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
-- vim.o.foldmethod = "marker"
vim.opt.foldenable=false

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25




vim.o.foldcolumn = '1' -- '0' is not bad
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true

-- vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
-- vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)












--
-- function get_lsp_client()
--    local msg = "No LSP"
--    local buf_ft = vim.api.nvim_get_option_value("filetype", { buf = 0 })
--    local clients = vim.lsp.get_clients { bufnr = 0 }
--    if next(clients) == nil then return msg end
--    local client_names = {}
--    for _, client in pairs(clients) do
--       table.insert(client_names, client.name)
--    end
--    return "[" .. table.concat(client_names, ", ") .. "]"
-- end
--
-- _G.lsp_msg = "" -- Initialize globally
--
-- vim.api.nvim_create_autocmd("LspProgress", {
--    callback = function(ev)
--       local value = ev.data.params.value
--       if not value then return end
--
--       if value.kind == "end" then
--          _G.lsp_msg = ""
--       else
--          local map = {
--             title = value.title,
--             message = value.message,
--             percentage = value.percentage,
--          }
--          local parts = {}
--          if map.title then table.insert(parts, map.title) end
--          if map.message then table.insert(parts, map.message) end
--          if map.percentage then table.insert(parts, map.percentage .. "%") end
--
--          _G.lsp_msg = table.concat(parts, " ")
--       end
--       vim.cmd "redrawstatus"
--    end,
-- })
-- function _G.get_lsp_status() return _G.lsp_msg end
--
-- function get_lint_status()
--    local diagnostics = vim.diagnostic.get(0)
--    local counts = { E = 0, W = 0, I = 0, H = 0 }
--
--    for _, d in ipairs(diagnostics) do
--       if d.severity == vim.diagnostic.severity.ERROR then
--          counts.E = counts.E + 1
--       elseif d.severity == vim.diagnostic.severity.WARN then
--          counts.W = counts.W + 1
--       elseif d.severity == vim.diagnostic.severity.INFO then
--          counts.I = counts.I + 1
--       elseif d.severity == vim.diagnostic.severity.HINT then
--          counts.H = counts.H + 1
--       end
--    end
--
--    if (counts.E + counts.W + counts.I + counts.H) == 0 then return "" end
--
--    return string.format(
--       "[E: %d W: %d I: %d H: %d]",
--       counts.E,
--       counts.W,
--       counts.I,
--       counts.H
--    )
-- end
-- vim.opt.statusline =
--    "%{mode()} %f %m %{v:lua.get_lsp_client()} %{v:lua.get_lsp_status()} %= %{v:lua.get_lint_status()}  %y %p%% %l:%c"



