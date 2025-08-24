# One day
- [x] change directory structure
- [x] add new keybinds
- [x] remove which-key, rust*
- [x] migrate from telescope -> fzf-lua
- [x] migrate from nvim-cmp -> blink
- [x] migrate from lualine -> mini.statusline
- [x] fix treesitter capture groups (missing dep)
- [x] fix lsp and fzf keybinds
- [x] fix ephemeral noneckpain scratchpad
- [x] add: debug print

- [ ] configure: trouble
- [ ] [`fzf` functions](https://github.com/junegunn/fzf/wiki/Examples-(vim))


debug print



## ideas
- snippet ideas somehwere
- history parse it and get rid of certain keywords like :q or :wq
    - autocommand? or probably bash on a cronjob
tmail - like terminal.shop, learn SFTP
-blog: death, passion and purpose and meaning
- mask cli md runner: what cna i do w/markdown and code blocks?

```sh
for dir in $(find /home/user/scripts -type d); do
    PATH="$PATH:$dir"
done
export PATH
```



```lua
-- Set general floating window options
vim.o.winblend = 10  -- transparency for floating windows
vim.o.pumblend = 10  -- transparency for popups
vim.api.nvim_set_hl(0, 'NormalFloat', {bg = 'None'})  -- remove background for floating windows

-- Customize border style for floating windows
vim.o.winborder = 'rounded'  -- Set 'rounded', 'single', 'double', etc.

-- Alternatively, for specific plugin floating windows:
vim.cmd([[autocmd FileType * setlocal winblend=15 pumblend=15]])
```
