local M = {}
-- local config = function()
-- 	require("nvim-treesitter.configs").setup({
-- 		ensure_installed = { "c", "python", "go", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline" },
-- 		playground = {
-- 			enable = false,
-- 			disable = {},
-- 			updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
-- 			persist_queries = false, -- Whether the query persists across vim sessions
-- 			keybindings = {
-- 				toggle_query_editor = "o",
-- 				toggle_hl_groups = "i",
-- 				toggle_injected_languages = "t",
-- 				toggle_anonymous_nodes = "a",
-- 				toggle_language_display = "I",
-- 				focus_language = "f",
-- 				unfocus_language = "F",
-- 				update = "R",
-- 				goto_node = "<cr>",
-- 				show_help = "?",
-- 			},
-- 		},
-- 		query_linter = {
-- 			enable = true,
-- 			use_virtual_text = true,
-- 			lint_events = { "BufWrite", "CursorHold" },
-- 		},
-- 		-- ignore_install = { "" }, -- List of parsers to ignore installing
-- 		-- highlight = {
-- 		-- 	enable = true,
-- 		--           -- disable = function(lang, buf)
-- 		--           --     local max_filesize = 100 * 1024 -- 100 KB
-- 		--           --     local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
-- 		--           --     if ok and stats and stats.size > max_filesize then
-- 		--           --         return true
-- 		--           --     end
-- 		--           -- end,
-- 		--
-- 		-- },
-- 		highlight = { enable = true },
-- 		indent = {
-- 			enable = true,
-- 			disable = {},
-- 		},
-- 		-- context_commentstring = {
-- 		--   enable = true
-- 		-- },
-- 	})
-- end
-- M.lazy = {
-- 	"nvim-treesitter/nvim-treesitter",
-- 	build = ":TSUpdate",
-- 	lazy = "false",
-- 	config = config,
-- 	dependencies = {
-- 		"nvim-treesitter/playground",
-- 	},
-- 	{ "nvim-treesitter/nvim-treesitter-context", config = true },
-- }

M.lazy = {
	"romus204/tree-sitter-manager.nvim",
	dependencies = {}, -- tree-sitter CLI must be installed system-wide
	config = function()
		require("tree-sitter-manager").setup({
			-- Default Options
			-- ensure_installed = {}, -- list of parsers to install at the start of a neovim session
			-- border = nil, -- border style for the window (e.g. "rounded", "single"), if nil, use the default border style defined by 'vim.o.winborder'. See :h 'winborder' for more info.
			-- auto_install = false, -- if enabled, install missing parsers when editing a new file
			-- highlight = true, -- treesitter highlighting is enabled by default
			-- languages = {}, -- override or add new parser sources
			-- parser_dir = vim.fn.stdpath("data") .. "/site/parser",
			-- query_dir = vim.fn.stdpath("data") .. "/site/queries",
		})
	end,
}
return M.lazy
