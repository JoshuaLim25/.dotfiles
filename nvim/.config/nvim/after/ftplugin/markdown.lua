-- NOTE: can just do `:e` to source after/ftplugin files
vim.opt_local.spell = true
vim.opt_local.spelllang = { "en_us" }

-- [[ **BOLD**/*ITALICIZE* SELECTION/WORD ]]
local keymap = vim.keymap.set
keymap('x', '<C-i>', [[:s/\%V.*\%V/\*&\*/<CR><cmd>noh<CR>]], { noremap = true, silent = true })
keymap('x', '<C-b>', [[:s/\%V.*\%V/\*\*&\*\*/<CR><cmd>noh<CR>]], { noremap = true, silent = true })
-- TODO: stop this from working in source code/empty files
-- keymap('n', '<C-i>', 'diwi*<Esc>pa*<Esc>', { noremap = true, silent = true, desc = 'Italicize Word Cursor Hovers Over' })
-- keymap('n', '<C-b>', 'diwi**<Esc>pa**<Esc>', { noremap = true, silent = true, desc = 'Emphasize Word Cursor Hovers Over' })


-- vim.opt_local.background = "light"
-- vim.cmd("colorscheme NeoSolarized")
