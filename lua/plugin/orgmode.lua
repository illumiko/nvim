return {

	"nvim-orgmode/orgmode",
	event = "VeryLazy",
	ft = { "org" },
	config = function()
		-- Setup orgmode
		require("orgmode").setup({
			org_agenda_files = { "~/Documents/org/semester/*",
            "~/Documents/org/journal/*","~/Documents/org/journal/weeks/*"  },
			org_default_notes_file = "~/Documents/org/",
		})
		vim.lsp.enable("org")
	end,
}
