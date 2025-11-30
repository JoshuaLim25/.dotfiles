-- NOTE: can just do `:e` to source after/ftplugin files
-- [[ **BOLD**/*ITALICIZE* SELECTION/WORD ]]
-- TODO: stop this from working in source code
-- local keymap = vim.keymap.set
-- keymap('x', '<C-i>', 's*<C-r>"*<Esc>', { noremap = true, silent = true, desc = 'Italicize Selected Text' })
-- keymap('n', '<C-i>', 'diwi*<Esc>pa*<Esc>', { noremap = true, silent = true, desc = 'Italicize Word Cursor Hovers Over' })
-- keymap('x', '<C-b>', 's**<C-r>"**<Esc>', { noremap = true, silent = true, desc = 'Emphasize Selected Text' })
-- keymap('n', '<C-b>', 'diwi**<Esc>pa**<Esc>', { noremap = true, silent = true, desc = 'Emphasize Word Cursor Hovers Over' })


-- -- change italics color
-- local blue = vim.api.nvim_get_hl(0, { name = "type" }).fg or "#9fb5c9"
-- vim.api.nvim_set_hl(0, "@markup.italic.markdown_inline", { fg = blue })
--
-- -- change bold colors
-- local yellow = vim.api.nvim_get_hl(0, { name = "identifier" }).fg or "#f0c674"
-- vim.api.nvim_set_hl(0, "@markup.strong.markdown_inline", { fg = yellow, bold = true })


-- vim.opt_local.background = "light"
-- vim.cmd("colorscheme NeoSolarized")
