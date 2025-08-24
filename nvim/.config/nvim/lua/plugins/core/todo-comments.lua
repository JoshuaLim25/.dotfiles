  return {
    "folke/todo-comments.nvim",
    opts = {
      colors = {
        error = '#a54242',
        info = '#81a2be',
        warning = '#f0c674',
        hint = '#87a987',
        default = '#b294bb',
        test = '#707880',
      },
      -- Show todo comments in the sign column but don't highlight the text
      highlight = {
        -- keyword = '',
        after = '',
      },
      signs = false, -- in sign column. Can configure on a keyword basis
      keywords = {
        FIX = {
          icon = " ",
          color = "error", -- can be a hex color, or a named color (see below)
          alt = { "FIXME", "FIXIT", "BUG", "ISSUE", "DEBUG" },
          -- signs = false,
        },
        TODO = { icon = " ", color = "info", },
        INFO = { icon = " ", color = "info", },
        NOTE = { icon = " ", color = "warning" },
        WARN = { icon = " ", color = "warning", alt = { "WARNING", "BAD" }, },
        PERF = { icon = " ", color = "hint", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
        SAFETY = { icon = "󰌾 ", color = "info", alt = { "SECURITY", "SECURE" } },

      },
    },
  }
