local none = {"Normal","NormalFloat","WinSeparator"}
function ColorMyPencils(color)
	color = color or "NeoSolarized"
	vim.cmd.colorscheme(color)

    for _,value in pairs(none) do
	    vim.api.nvim_set_hl(0, value, {bg="none",fg="none"})
    end
end


require("NeoSolarized").setup {
  style = "dark", -- "dark" or "light"
  transparent = true,
}
ColorMyPencils('NeoSolarized')
