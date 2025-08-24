return {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VimEnter",
    opts = {
        files = {
            hidden = true,
            fd_opts = "--type f --hidden --exclude .git",
        },
        grep = {
            rg_opts = "--column --line-number --no-heading --color=always --smart-case --hidden -g '!.git/'",
        },
        fzf_opts = {
            ["--info"] = "default",
            -- ["--layout"] = "default",  -- puts searchbar in middle
        },
    },
    config = function(_, opts)
        local fzf = require("fzf-lua")
        fzf.setup(opts)
        fzf.register_ui_select()

        local keymap = vim.keymap.set

        -- [[ FILE/SEARCH ]]
        keymap("i", "<C-f>", function() fzf.complete_path() end)
        keymap("n", "<leader>ff", function() fzf.files() end, { desc = "[F]ind [F]iles in project directory" })
        keymap("n", "<leader>fg", function() fzf.live_grep() end, { desc = "[F]ind via fuzzy [G]rep in project directory" })
        keymap("n", "<leader>fH", fzf.helptags, { desc = "[F]ind neovim [H]elp docs" })
        keymap("n", "<leader>fk", fzf.keymaps, { desc = "[F]ind [K]eymaps" })
        keymap("n", "<leader>fb", fzf.builtin, { desc = "[F]ind [B]uiltins offered by fzf" })
        keymap("n", "<leader>fw", fzf.grep_cword, { desc = "[F]ind occurrences of [W]ord on cursor" })
        keymap("n", "<leader>fW", fzf.grep_cWORD, { desc = "[F]ind occurrences of [W]ORD on cursor" })
        keymap("n", "<leader>fd", fzf.diagnostics_document, { desc = "[F]ind [D]iagnostics" })
        keymap("n", "<leader>fr", fzf.resume, { desc = "[F]ind [R]esume" })
        keymap("n", "<leader>fo", fzf.oldfiles, { desc = "[F]ind [O]ld Files" })
        keymap("n", "<leader><leader>", fzf.buffers, { desc = "See existing buffers" })
        keymap("n", "<leader>/", fzf.lgrep_curbuf, { desc = "Grep in current buffer" })
        keymap("n", "<leader>fn", function() fzf.files({ cwd = vim.fn.stdpath("config") }) end, { desc = "Find in Neovim config" })

        -- [[ LSP KEYMAPS ]]
        keymap("n", "<leader>cap", fzf.lsp_code_actions, { desc = "Code actions" })
        keymap("n", "gd", fzf.lsp_definitions, { desc = "Go to definition" })
        keymap("n", "gr", fzf.lsp_references, { desc = "Go to references" })
        keymap("n", "<leader>fs", fzf.lsp_document_symbols, { desc = "Find symbols in document" })
        keymap("n", "<leader>fS", fzf.lsp_workspace_symbols, { desc = "Find symbols in workspace" })

        vim.api.nvim_create_user_command("FzfDots", function()
            fzf.files({ cwd = "$HOME/.dotfiles" })
        end, {})
    end,
}
