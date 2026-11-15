return {
	"uga-rosa/ccc.nvim",
    cmd = {
        "CccConvert",
        "CccPick",
        "CccHighlighterToggle"


    },
	config = function()
		require("ccc").setup({})
	end,
}
