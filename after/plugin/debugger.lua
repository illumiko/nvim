local dap = require('dap')
require('dapui').setup()

vim.keymap.set('n', '<leader>ds', function() dap.continue() end)
vim.keymap.set('n', '<leader>do', function() dap.step_over() end)
vim.keymap.set('n', '<leader>dj', function() dap.step_into() end)
vim.keymap.set('n', '<leader>dk', function() dap.step_out() end)
vim.keymap.set('n', '<Leader>b', function() dap.toggle_breakpoint() end)
vim.keymap.set('n', '<Leader>B', function() dap.set_breakpoint() end)
vim.keymap.set('n', '<Leader>lp', function() dap.
    set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end)
vim.keymap.set('n', '<Leader>dr', function() dap.repl.open() end)
vim.keymap.set('n', '<Leader>dl', function() dap.run_last() end)

vim.keymap.set({'n', 'v'}, '<Leader>dh', function()
    require('dap.ui.widgets').hover()
end)

vim.keymap.set({'n', 'v'}, '<Leader>dp', function()
    require('dap.ui.widgets').preview()
end)

vim.keymap.set('n', '<Leader>df', function()
    local widgets = require('dap.ui.widgets')
    widgets.centered_float(widgets.frames)
end)

vim.keymap.set('n', '<Leader>ds', function()
    local widgets = require('dap.ui.widgets')
    widgets.centered_float(widgets.scopes)
end)


dap.adapters.python = {
    type = 'executable';
    command = '/home/miko/.virtualenvs/debugpy/bin/python3';
    args = { '-m', 'debugpy.adapter' };
}

dap.configurations.python = {
    {
        type = 'python';
        request = 'launch';
        name = "Launch file";
        program = "${file}";
        pythonPath = function()
            return '/home/miko/.virtualenvs/debugpy/bin/python3'
        end;
    },
}
