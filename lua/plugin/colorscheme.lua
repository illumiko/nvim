local config = {}
-- config.tokyonight = {style = 'day'}

config.kanagawa = function()
	require("kanagawa").setup({
		undercurl = true, -- enable undercurls
		commentStyle = { italic = false },
		functionStyle = { italic = false },
		keywordStyle = { bold = true },
		statementStyle = { bold = true },
		typeStyle = { bold = true, italic = false },
		variablebuiltinStyle = {},
		specialReturn = true, -- special highlight for the return keyword
		specialException = true, -- special highlight for exception handling keywords
        transparent = false, -- do not set background color
		dimInactive = true, -- dim inactive window `:h hl-NormalNC`
		globalStatus = true,
	})
	vim.cmd([=[
hi link CmpPmenu Normal
]=])
end

config.gruvbox = function()
	require("gruvbox").setup({
		undercurl = true,
		underline = true,
		bold = true,
		-- italic = true,
		strikethrough = true,
		invert_selection = false,
		invert_signs = false,
		invert_tabline = false,
		invert_intend_guides = true,
		inverse = false, -- invert background for search, diffs, statuslines and errors
		contrast = "soft", -- can be "hard", "soft" or empty string
		palette_overrides = {},
		overrides = {},
		dim_inactive = true,
		transparent_mode = false,
	})
	vim.cmd([=[
hi IndentBlanklineChar guifg=none
hi TreesitterContext guibg=#222222
]=])
end

config.zenbones = function ()
end

config.onedark = function () 
-- Lua
require('onedark').setup  {
    -- Main options --
    style = 'light', -- Default theme style. Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
    transparent = false,  -- Show/hide background
    term_colors = true, -- Change terminal color as per the selected theme style
    ending_tildes = false, -- Show the end-of-buffer tildes. By default they are hidden
    cmp_itemkind_reverse = false, -- reverse item kind highlights in cmp menu

    -- toggle theme style ---
    toggle_style_key = nil, -- keybind to toggle theme style. Leave it nil to disable it, or set it to a string, for example "<leader>ts"
    toggle_style_list = {'dark', 'darker', 'cool', 'deep', 'warm', 'warmer', 'light'}, -- List of styles to toggle between

    -- Change code style ---
    -- Options are italic, bold, underline, none
    -- You can configure multiple style with comma separated, For e.g., keywords = 'italic,bold'
    code_style = {
        comments = 'italic',
        keywords = 'none',
        functions = 'none',
        strings = 'none',
        variables = 'none'
    },

    -- Lualine options --
    -- Custom Highlights --
    colors = {}, -- Override default colors
    highlights = {}, -- Override highlight groups

    -- Plugins Config --
    diagnostics = {
        darker = true, -- darker colors for diagnostic
        undercurl = true,   -- use undercurl instead of underline for diagnostics
        background = true,    -- use background color for virtual text
    },
}
end

config.onenord = function ()
    require('onenord').setup({
      theme = "light", -- "dark" or "light". Alternatively, remove the option and set vim.o.background instead
      borders = true, -- Split window borders
      fade_nc = true, -- Fade non-current windows, making them more distinguishable
      -- Style that is applied to various groups: see `highlight-args` for options
      styles = {
        comments = "NONE",
        strings = "NONE",
        keywords = "NONE",
        functions = "NONE",
        variables = "NONE",
        diagnostics = "underline",
      },
      disable = {
        background = false, -- Disable setting the background color
        float_background = false, -- Disable setting the background color for floating windows
        cursorline = true, -- Disable the cursorline
        eob_lines = true, -- Hide the end-of-buffer lines
      },
      -- Inverse highlight for different groups
      inverse = {
        match_paren = false,
      },
      custom_highlights = {}, -- Overwrite default highlight groups
      custom_colors = {}, -- Overwrite default colors
    })
end
config.catppucnin = function ()
    require("catppuccin").setup({
        flavour = "latte", -- latte, frappe, macchiato, mocha
        background = { -- :h background
            light = "latte",
            dark = "latte",
        },
        transparent_background = false, -- disables setting the background color.
        show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
        term_colors = false, -- sets terminal colors (e.g. `g:terminal_color_0`)
        dim_inactive = {
            enabled = false, -- dims the background color of inactive window
            shade = "light",
            percentage = 50.55, -- percentage of the shade to apply to the inactive window
        },
        no_italic = false, -- Force no italic
        no_bold = false, -- Force no bold
        no_underline = false, -- Force no underline
        styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
            comments = { "italic" }, -- Change the style of comments
            conditionals = { "italic" },
            loops = {},
            functions = {},
            keywords = {},
            strings = {},
            variables = {},
            numbers = {},
            booleans = {},
            properties = {},
            types = {},
            operators = {},
            -- miscs = {}, -- Uncomment to turn off hard-coded styles
        },
        color_overrides = {},
        custom_highlights = {},
        default_integrations = true,
        integrations = {
            cmp = true,
            gitsigns = true,
            nvimtree = false,
            treesitter = true,
            notify = false,
            mini = {
                enabled = true,
                indentscope_color = "",
            },
            -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
        },
    })

end

config.solarized = function ()
    local ok_status, NeoSolarized = pcall(require, "NeoSolarized")
    if not ok_status then
      return
    end
    -- Default Setting for NeoSolarized
    NeoSolarized.setup {
      style = "dark", -- "dark" or "light"
      transparent = true, -- true/false; Enable this to disable setting the background color
      terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
      enable_italics = true, -- Italics for different hightlight groups (eg. Statement, Condition, Comment, Include, etc.)
      styles = {
        -- Style to be applied to different syntax groups
        comments = { italic = true },
        keywords = { italic = true },
        functions = { bold = true },
        variables = {},
        string = { italic = true },
        underline = true, -- true/false; for global underline
        undercurl = true, -- true/false; for global undercurl
      },
      -- Add specific hightlight groups
      on_highlights = function(highlights, colors) 
        -- highlights.Include.fg = colors.red -- Using `red` foreground for Includes
      end, 
    }
    -- Set colorscheme to NeoSolarized
end
local plugins = {
    {"Tsuzat/NeoSolarized.nvim", lazy = false, config=config.solarized},
    { "folke/tokyonight.nvim", lazy = false, priority = 1000, },
    { "catppuccin/nvim", name = "catppuccin", priority = 1000, config = config.catppucnin},
	{ "ellisonleao/gruvbox.nvim", lazy = true, config = config.gruvbox },
	{ "rockyzhang24/arctic.nvim", branch = "v2" },
	{"rebelot/kanagawa.nvim", lazy = true, config = config.kanagawa},
    {"zenbones-theme/zenbones.nvim", lazy=true},
    {"kdheepak/monochrome.nvim", lazy=true},
    {"navarasu/onedark.nvim", lazy = true},
    {"rmehri01/onenord.nvim", opts = config.onenord}
}

return plugins
