local M = {}
local config = function()
	local util = require("formatter.util")

	require("formatter").setup({
      logging = true,
      -- Set the log level
      log_level = vim.log.levels.WARN,
		filetype = {
			lua = {
				require("plugin.format.filetype_conf.lua").stylua,
			},
			javascript = {
				require("plugin.format.filetype_conf.javascript").prettiereslint,
				function()
					return {
						exe = "prettier-eslint",
						args = {
							"--tabWidth 2",
							"--stdin",
							"--stdin-filepath",
							util.escape_path(util.get_current_buffer_file_path()),
						},
						stdin = true,
						try_node_modules = true,
					}
				end,
			},
			json = {
				require("plugin.format.filetype_conf.json").prettier,
			},
			jsonc = {
				require("plugin.format.filetype_conf.json").prettier,
			},
			typescript = {
				require("plugin.format.filetype_conf.typescript").prettiereslint,
			},
			go = {
				require("plugin.format.filetype_conf.go").goimports,
			},
            python = {
                require("plugin.format.filetype_conf.python").isort()
            }
			-- vimwiki = {
			-- 	require("plugin.format.filetype_conf.markdown").markdownlint,
			-- },
		},
	})
	vim.cmd([[
augroup FormatAutogroup
  autocmd!
  autocmd FileType go autocmd InsertLeave * Format
augroup END
]])

end
local confi = function()
-- Utilities for creating configurations
local util = require "formatter.util"

-- Provides the Format, FormatWrite, FormatLock, and FormatWriteLock commands
require("formatter").setup {
  -- Enable or disable logging
  logging = true,
  -- Set the log level
  log_level = vim.log.levels.WARN,
  -- All formatter configurations are opt-in
  filetype = {
    -- Formatter configurations for filetype "lua" go here
    -- and will be executed in order
    lua = {
      -- "formatter.filetypes.lua" defines default configurations for the
      -- "lua" filetype
      require("formatter.filetypes.lua").stylua,

      -- You can also define your own configuration
      function()
        -- Supports conditional formatting
        if util.get_current_buffer_file_name() == "special.lua" then
          return nil
        end

        -- Full specification of configurations is down below and in Vim help
        -- files
        return {
          exe = "stylua",
          args = {
            "--search-parent-directories",
            "--stdin-filepath",
            util.escape_path(util.get_current_buffer_file_path()),
            "--",
            "-",
          },
          stdin = true,
        }
      end
    },

    -- Use the special "*" filetype for defining formatter configurations on
    -- any filetype
    ["*"] = {
      -- "formatter.filetypes.any" defines default configurations for any
      -- filetype
      require("formatter.filetypes.any").remove_trailing_whitespace,
      -- Remove trailing whitespace without 'sed'
      -- require("formatter.filetypes.any").substitute_trailing_whitespace,
    }
  }
}
end
M.lazy = {
	"mhartington/formatter.nvim",
	config = config,
}

return M.lazy
