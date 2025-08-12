-- [[ DIAGNOSTICS ]] {{
-- [[ BASIC MAPPINGS ]]
local keymap = vim.keymap.set
keymap('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
keymap('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
keymap('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- [[ TOGGLE DIAGNOSTICS ]]
local diagnostics_enabled = true
keymap('n', '<leader>dd', function()
    diagnostics_enabled = not diagnostics_enabled
    if diagnostics_enabled then
        vim.diagnostic.enable()
        print("LSP diagnostics enabled")
    else
        vim.diagnostic.disable()
        print("LSP diagnostics disabled")
    end
end, { desc = 'Toggle LSP diagnostics' })


-- [[ DISABLE ALL LSP ]]
local lsp_enabled = true
keymap('n', '<leader>dl', function()
    vim.cmd('LspStop')
    -- vim.diagnostic.disable()
    print("LSP disabled")
end, { desc = 'Toggle all LSP functionality' })

-- [[ VISUALS ]]
vim.fn.sign_define('DiagnosticSignError', { text = '󰅚 ', texthl = 'DiagnosticSignError' })
vim.fn.sign_define('DiagnosticSignWarn', { text = '󰀪 ', texthl = 'DiagnosticSignWarn' })
vim.fn.sign_define('DiagnosticSignInfo', { text = '', texthl = 'DiagnosticSignInfo' })
vim.fn.sign_define('DiagnosticSignHint', { text = '󰋽 ', texthl = 'DiagnosticSignHint' })

-- :h vim.diagnostic.Opts
vim.diagnostic.config {
    -- underline = { severity = vim.diagnostic.severity.ERROR },
    underline = true,
    update_in_insert = false,
    severity_sort = true,
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = '󰅚 ',
            [vim.diagnostic.severity.WARN] = '󰀪 ',
            [vim.diagnostic.severity.INFO] = '󰋽 ',
            [vim.diagnostic.severity.HINT] = '',
        },
    },
    virtual_text = {
        prefix = '■ ', -- Could be '●', '▎', 'x', '■', ,   ⚙ 🗝
        spacing = 2,
        -- format -- used to customize/filter diag text
    },
    float = {
        -- source = 'if_many'
        border = 'rounded',
        title = 'Diagnostics',
        title_pos = 'left',
        header = '',
    },
}

-- }}
