return {
	"chomosuke/typst-preview.nvim",
	ft = "typst",
	version = "1.*",
	opts = {
		debug = true,
		open_cmd = "xdg-open %s",
		dependencies_bin = {
			-- make sure these are available in $PATH.
			-- Comment the lines below to automatically download these bin.
			-- NOTE: downloaded bin doesn't work on nixos D:
			-- ["tinymist"] = "tinymist",
			-- ["websocat"] = "websocat",
		},
	},
}
