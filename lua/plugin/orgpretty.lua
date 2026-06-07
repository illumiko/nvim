return {
	"akinsho/org-bullets.nvim",
	ft = { "org" },
	config = function()
		require("org-bullets").setup({
			concealcursor = true, -- If false then when the cursor is on a line underlying characters are visible
			symbols = {
				-- list symbol
				list = "•",
				-- headlines can be a list
				headlines = { " ◉", " ○", " ✸", " ✿" },
			},
		})
	end,
}
