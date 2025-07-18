-- local status_ok, navic = pcall(require, "nvim-navic")
-- if not status_ok then
--   return
-- end
--
local M = {}
local config = function()
	local icons = require("utils.icons")
	local navic = require("nvim-navic")
	navic.setup({
		icons = {
			File = " ",
			Module = " ",
			Namespace = " ",
			Package = " ",
			Class = " ",
			Method = " ",
			Property = " ",
			Field = " ",
			Constructor = " ",
			Enum = " ",
			Interface = " ",
			Function = " ",
			Variable = " ",
			Constant = " ",
			String = " ",
			Number = " ",
			Boolean = " ",
			Array = " ",
			Object = " ",
			Key = " ",
			Null = " ",
			EnumMember = " ",
			Struct = " ",
			Event = " ",
			Operator = " ",
			TypeParameter = " ",
		},
		highlight = true,
		separator = " " .. icons.ui.ChevronRight .. " ",
		-- separator = " > ",
		depth_limit = 0,
		depth_limit_indicator = "..",
	})
	vim.api.nvim_set_hl(0, "NavicIconsFile", { default = true, bg = "none", fg = "#ffffff" })
	vim.api.nvim_set_hl(0, "NavicIconsModule", { default = true, bg = "none", fg = "#ffffff" })
	vim.api.nvim_set_hl(0, "NavicIconsNamespace", { default = true, bg = "none", fg = "#ffffff" })
	vim.api.nvim_set_hl(0, "NavicIconsPackage", { default = true, bg = "none", fg = "#ffffff" })
	vim.api.nvim_set_hl(0, "NavicIconsClass", { default = true, bg = "none", fg = "#ffffff" })
	vim.api.nvim_set_hl(0, "NavicIconsMethod", { default = true, bg = "none", fg = "#ffffff" })
	vim.api.nvim_set_hl(0, "NavicIconsProperty", { default = true, bg = "none", fg = "#ffffff" })
	vim.api.nvim_set_hl(0, "NavicIconsField", { default = true, bg = "none", fg = "#ffffff" })
	vim.api.nvim_set_hl(0, "NavicIconsConstructor", { default = true, bg = "none", fg = "#ffffff" })
	vim.api.nvim_set_hl(0, "NavicIconsEnum", { default = true, bg = "none", fg = "#ffffff" })
	vim.api.nvim_set_hl(0, "NavicIconsInterface", { default = true, bg = "none", fg = "#ffffff" })
	vim.api.nvim_set_hl(0, "NavicIconsFunction", { default = true, bg = "none", fg = "#ffffff" })
	vim.api.nvim_set_hl(0, "NavicIconsVariable", { default = true, bg = "none", fg = "#ffffff" })
	vim.api.nvim_set_hl(0, "NavicIconsConstant", { default = true, bg = "none", fg = "#ffffff" })
	vim.api.nvim_set_hl(0, "NavicIconsString", { default = true, bg = "none", fg = "#ffffff" })
	vim.api.nvim_set_hl(0, "NavicIconsNumber", { default = true, bg = "none", fg = "#ffffff" })
	vim.api.nvim_set_hl(0, "NavicIconsBoolean", { default = true, bg = "none", fg = "#ffffff" })
	vim.api.nvim_set_hl(0, "NavicIconsArray", { default = true, bg = "none", fg = "#ffffff" })
	vim.api.nvim_set_hl(0, "NavicIconsObject", { default = true, bg = "none", fg = "#ffffff" })
	vim.api.nvim_set_hl(0, "NavicIconsKey", { default = true, bg = "none", fg = "#ffffff" })
	vim.api.nvim_set_hl(0, "NavicIconsNull", { default = true, bg = "none", fg = "#ffffff" })
	vim.api.nvim_set_hl(0, "NavicIconsEnumMember", { default = true, bg = "none", fg = "#ffffff" })
	vim.api.nvim_set_hl(0, "NavicIconsStruct", { default = true, bg = "none", fg = "#ffffff" })
	vim.api.nvim_set_hl(0, "NavicIconsEvent", { default = true, bg = "none", fg = "#ffffff" })
	vim.api.nvim_set_hl(0, "NavicIconsOperator", { default = true, bg = "none", fg = "#ffffff" })
	vim.api.nvim_set_hl(0, "NavicIconsTypeParameter", { default = true, bg = "none", fg = "#ffffff" })
	vim.api.nvim_set_hl(0, "NavicText", { default = true, bg = "none", fg = "#ffffff" })
	vim.api.nvim_set_hl(0, "NavicSeparator", { default = true, bg = "none", fg = "#ffffff" })
end

M.lazy = {
	-- "utilyre/barbecue.nvim",
	-- -- name = "barbecue",
	-- version = "*",
	-- dependencies = {
	-- 	"SmiteshP/nvim-navic",
	-- },
	-- config = true,
}

return M.lazy
