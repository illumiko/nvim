local dap_config = function()
	local dap = require("dap")
	dap.adapters.gdb = {
		type = "executable",
		command = "gdb",
		args = { "--interpreter=dap", "--eval-command", "set print pretty on" },
	}
	dap.configurations.c = {
		{
			name = "Launch",
			type = "gdb",
			request = "launch",
			program = function()
				return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
			end,
			args = {}, -- provide arguments if needed
			cwd = "${workspaceFolder}",
			stopAtBeginningOfMainSubprogram = false,
		},
		{
			name = "Select and attach to process",
			type = "gdb",
			request = "attach",
			program = function()
				return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
			end,
			pid = function()
				local name = vim.fn.input("Executable name (filter): ")
				return require("dap.utils").pick_process({ filter = name })
			end,
			cwd = "${workspaceFolder}",
		},
		{
			name = "Attach to gdbserver :1234",
			type = "gdb",
			request = "attach",
			target = "localhost:1234",
			program = function()
				return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
			end,
			cwd = "${workspaceFolder}",
		},
	}
	dap.configurations.cpp = dap.configurations.c
end
local dap_python_config = function ()
    require("dap-python").setup("python3")
end
return {
	{ "mfussenegger/nvim-dap", config = dap_config },
	{ --dap view
		"igorlfs/nvim-dap-view",
		---@module 'dap-view'
		---@type dapview.Config
		opts = {},
	},
    {"https://codeberg.org/mfussenegger/nvim-dap-python", config = dap_python_config},
	-- {
	-- 	"rcarriga/nvim-dap-ui",
	-- 	dependencies = { "nvim-neotest/nvim-nio" },
	-- 	-- config = function()
	-- 	-- 	local dap, dapui = require("dap"), require("dapui")
	-- 	-- 	dap.listeners.before.attach.dapui_config = function()
	-- 	-- 		dapui.open()
	-- 	-- 	end
	-- 	-- 	dap.listeners.before.launch.dapui_config = function()
	-- 	-- 		dapui.open()
	-- 	-- 	end
	-- 	-- 	dap.listeners.before.event_terminated.dapui_config = function()
	-- 	-- 		dapui.close()
	-- 	-- 	end
	-- 	-- 	dap.listeners.before.event_exited.dapui_config = function()
	-- 	-- 		dapui.close()
	-- 	-- 	end
	-- 	-- end,
	-- },
	{ --langauge specific
		{ "leoluz/nvim-dap-go", config = true },
	},
}
