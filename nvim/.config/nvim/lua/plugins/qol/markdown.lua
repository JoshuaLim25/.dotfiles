-- https://github.com/wfxr/dotfiles/blob/cd5227f0832581b7507b10358a130fd68396e247/vim/nvim/lua/plugins/editor.lua#L109
return  {
  -- in editor
  {
    "iamcco/markdown-preview.nvim",
    enabled = not vim.env.SSH_CLIENT and vim.fn.filereadable("/.dockerenv") == 0,
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = "cd app && yarn install",
    keys = {
      {
        "<leader>md",
        ft = "markdown",
        "<cmd>MarkdownPreviewToggle<cr>",
        desc = "Markdown Preview",
      },
    },
    config = function()
      vim.cmd([[do FileType]])
    end,
  },

  -- in editor
  {
    "MeanderingProgrammer/render-markdown.nvim",
    opts = {
      code = {
        width = "block",
        position = "left",
        right_pad = 1,
        left_pad = 1,
      },
    },
  },
}
