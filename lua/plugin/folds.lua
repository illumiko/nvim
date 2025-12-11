-- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself

local config = function ()
    require('ufo').setup({
    provider_selector = function(bufnr, filetype, buftype)
        return {'lsp', 'indent'}
    end
})
end
--
return {
'kevinhwang91/nvim-ufo', dependencies = 'kevinhwang91/promise-async',
config = config
}
