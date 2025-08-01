vim.lsp.enable({"lua_ls","gopls"})
vim.diagnostic.config({virtual_text = {current_line=true}})
return {
    "neovim/nvim-lspconfig"
}
