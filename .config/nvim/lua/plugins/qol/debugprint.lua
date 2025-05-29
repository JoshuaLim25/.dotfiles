-- https://github.com/andrewferrier/debugprint.nvim/blob/main/SHOWCASE.md#restoring-non-persistent-display_counter-counter
local counter = 0
local counter_func = function()
    counter = counter + 1
    return '[' .. tostring(counter) .. ']'
end

return {
    "andrewferrier/debugprint.nvim",
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "ibhagwan/fzf-lua",     -- Optional, for `:Debugprint search`
    },
    lazy = false,
    opts = {
        -- https://github.com/andrewferrier/debugprint.nvim?tab=readme-ov-file#keymappings-and-commands
        keymaps = {
            normal = {
                plain_below = "",
                plain_above = "",
                variable_below = "<leader>l",
                variable_above = "<leader>L",
                variable_below_alwaysprompt = "",
                variable_above_alwaysprompt = "",
                surround_plain = "",
                surround_variable = "sul",  -- overrides mini.surround
                surround_variable_alwaysprompt = "",
                textobj_below = "",
                textobj_above = "",
                textobj_surround = "",
                toggle_comment_debug_prints = "",
                delete_debug_prints = "<leader>dld",
            },
            insert = {
                plain = "",
                variable = "<C-D>l",
            },
            visual = {
                variable_below = "",
                variable_above = "",
            },
        },  -- keymaps
        -- vim.api.nvim_set_hl(0, 'DebugPrintLine', { fg = "#de935f", bg = "" }),
        highlight_lines = false,
        print_tag = "DEBUG",
        display_counter = counter_func,
        filetypes = {
            -- defaults: https://github.com/andrewferrier/debugprint.nvim/blob/7f2dcdd12db17d551641134bfd07cc395b0fccef/lua/debugprint/filetypes.lua
            -- Construction of debug statment is as follows:
            -- left_var + "DEBUG[1]: main.go:8: VAR=" + mid_var + VAR + right_var
            ["go"] = {
                left_var = 'fmt.Fprintf(os.Stderr, "',
                right = '\\n")',
                mid_var = '%+v\\n", ',
                -- mid_var = '%#v\\n", ',
                right_var = ")",
            },
        }
    },  -- opts
}
