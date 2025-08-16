vim.lsp.enable({"lua_ls","gopls","emmet_language_server"})
vim.diagnostic.config({virtual_text = {current_line=true}})
return {
    "neovim/nvim-lspconfig"
}
