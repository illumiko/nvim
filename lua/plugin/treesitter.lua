local M = {}
local config = function()
	require("nvim-treesitter.configs").setup({
        ensure_installed = { "c","go", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline" },
		playground = {
			enable = false,
			disable = {},
			updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
			persist_queries = false, -- Whether the query persists across vim sessions
			keybindings = {
				toggle_query_editor = "o",
				toggle_hl_groups = "i",
				toggle_injected_languages = "t",
				toggle_anonymous_nodes = "a",
				toggle_language_display = "I",
				focus_language = "f",
				unfocus_language = "F",
				update = "R",
				goto_node = "<cr>",
				show_help = "?",
			},
		},
		query_linter = {
			enable = true,
			use_virtual_text = true,
			lint_events = { "BufWrite", "CursorHold" },
		},
		ignore_install = { "" }, -- List of parsers to ignore installing
		highlight = {
			enable = true,
            disable = function(lang, buf)
                local max_filesize = 100 * 1024 -- 100 KB
                local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
                if ok and stats and stats.size > max_filesize then
                    return true
                end
            end,
		},
		indent = {
			enable = true,
			disable = {},
		},
		-- context_commentstring = {
		--   enable = true
		-- },
	})
end
M.lazy = {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
    lazy = "false",
	config = config,
	dependencies = {
		"nvim-treesitter/playground",
	},
    {"nvim-treesitter/nvim-treesitter-context", config=true}
}
return M.lazy
