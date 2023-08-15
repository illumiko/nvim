----------------------------------------------
--
--[[#PLUGINS]]
----------------------------------------------
local fn = vim.fn
-- Automatically install packer
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"--single-branch",
		"https://github.com/folke/lazy.nvim.git",
		lazypath,
	})
end
vim.opt.runtimepath:prepend(lazypath)
vim.g.mapleader = " "
vim.opt.termguicolors = true -- set term gui colors (most terminals support this)

-- Autocommand that reloads neovim whenever you save the plugins.lua file

-- Use a protected call so we don't error out on first use
local status_ok, lazy = pcall(require, "lazy")
if not status_ok then
	return
end

-- Have packer use a popup window
lazy.setup({
	{
		'nvim-telescope/telescope.nvim', tag = '0.1.2',
		dependencies = { 'nvim-lua/plenary.nvim' } 
	},

	{
		'rose-pine/neovim', name = 'rose-pine', config= function() vim.cmd("colorscheme rose-pine")end
	},

	{
		"nvim-treesitter/nvim-treesitter",
		events = { "BufEnter" },
		build = ":TSUpdate",
		config = config,
	--dependencies = {
	--	"nvim-treesitter/playground",
	--	"windwp/nvim-ts-autotag",
	--	"p00f/nvim-ts-rainbow",
	--	"David-Kunz/markid",
	--},
	},

	"theprimeagen/harpoon",
	"theprimeagen/refactoring.nvim",
	"mbbill/undotree",
	"tpope/vim-fugitive",
	"nvim-treesitter/nvim-treesitter-context",

	{
		'VonHeikemen/lsp-zero.nvim',
		branch = 'v1.x',
		dependencies = {
			-- LSP Support
			{'neovim/nvim-lspconfig'},
			{'williamboman/mason.nvim'},
			{'williamboman/mason-lspconfig.nvim'},

			-- Autocompletion
			{'hrsh7th/nvim-cmp'},
			{'hrsh7th/cmp-buffer'},
			{'hrsh7th/cmp-path'},
			{'saadparwaiz1/cmp_luasnip'},
			{'hrsh7th/cmp-nvim-lsp'},
			{'hrsh7th/cmp-nvim-lua'},

			-- Snippets
			{'L3MON4D3/LuaSnip'},
			{'rafamadriz/friendly-snippets'},
		}
	}


})
