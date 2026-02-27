vim.lsp.enable({
	-- "pyright",
	"jedi_language_server",
	"java_language_server",
	"qmlls",
	"lua_ls",
	"gopls",
	"emmet_language_server",
	"ts_ls",
	"clangd",
    -- "rust_analyzer",
})
vim.lsp.config["emmet_language_server"] = {
	filetypes = {
		"astro",
		"css",
		"eruby",
		"html",
		"htmlangular",
		"htmldjango",
		"javascriptreact",
		"less",
		"pug",
		"sass",
		"scss",
		"svelte",
		"templ",
		"typescriptreact",
		"vue",
		"tmpl",
		"template",
	},
}
vim.lsp.config["qmlls"] = {
	cmd = { "qmlls6", "-E" },
}
vim.lsp.config["gopls"] = {
	settings = {
		gopls = {
			hints = {
				rangeVariableTypes = true,
				parameterNames = true,
				constantValues = true,
				assignVariableTypes = true,
				compositeLiteralFields = true,
				compositeLiteralTypes = true,
				functionTypeParameters = true,
			},
		},
	},
}
vim.diagnostic.config({ virtual_text = { current_line = true } })
vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
return {
	"neovim/nvim-lspconfig",
	-- "MysticalDevil/inlay-hints.nvim",
	--   event = "LspAttach",
	--   dependencies = { "neovim/nvim-lspconfig" },
	--   config = function()
	--       require("inlay-hints").setup({
	--           commands = {enabled= true},
	--           autocmd = {enabled = true}
	--       })
	--   end

	{
		"chrisgrieser/nvim-lsp-endhints",
		event = "LspAttach",
		opts = {}, -- required, even if empty
	},
	"RRethy/vim-illuminate",
}
