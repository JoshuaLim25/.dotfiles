# [[ POWERLEVEL10K INSTANT PROMPT ]] {{
# NOTE: should stay close to the top of ~/.zshrc.
# NOTE: initialization code that may REQUIRE CONSOLE INPUT (password prompts, [y/n]
# confirmations, etc.) MUST GO ABOVE this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
# if [[ -f "/opt/homebrew/bin/brew" ]] then
#   # If you're using macOS, you'll want this enabled
#   eval "$(/opt/homebrew/bin/brew shellenv)"
# fi
# Hacky fix I was using to get rid of error message
# typeset -g POWERLEVEL9K_INSTANT_PROMPT=off
# }}

# Directory to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Check for Zinit
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/load Zinit
source "${ZINIT_HOME}/zinit.zsh"

# [[ EXPORTS ]] {{
# NOTE: you want to define that directory to the path variable, not the actual binary:
# EG: `PATH=$MYDIR:$PATH`, where MYDIR is def as the dir containing your binary
# NOTE: ORDER MATTERS. For `LHS:RHS,` LHS is the prepended head, RHS is the appended tail
# NOTE: symlinked to ~/.dotfiles/scripts
export PATH=$PATH:~/.local/bin
export PATH=$PATH:~/.local/bin/scripts

# [[ NVIM ]]
export EDITOR="$(which nvim)"
export VISUAL="$(which nvim)"
export FCEDIT="$(which nvim)"
export MANPAGER='nvim +Man!'
# export NVIM_APPNAME='nvim.bak'
# export NVIM_APPNAME='nvim-test'
export NVIM_APPNAME='nvim'
export PATH="$HOME/.local/share/nvim/mason/bin:$PATH" # NOTE: change if using diff NVIM_APPNAME


# RUSTUP TAB COMPLETIONS
fpath+=~/.zfunc

# # SCRIPT ORGANIZATION
# # https://stackoverflow.com/questions/24583863/how-do-i-organize-my-zsh-code-multiple-methods-in-single-file-vs-multiple-files?utm_source=chatgpt.com
# fpath=(~/.zsh_functions $fpath)
# autoload -Uz myfunc1 myfunc2

# BAT COLOR
export BAT_THEME="ansi"

# TODO: diff bw this and what's in ./.zshenv?
# export PATH="$HOME/.cargo/bin:$PATH"

# TODO: python path edition
# export PYTHONPATH="`pwd`:$PYTHONPATH"
# }}

# [[ ADDITIONAL ZINIT/PROMPT CONFIGURATION ]] {{
zinit ice depth=1; zinit light romkatv/powerlevel10k # Add Powerlevel10k
# NOTE: to customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# [[ ZSH PLUGINS ]]
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab
zinit light kutsan/zsh-system-clipboard

# [[ SNIPPETS ]]
# Don't use, but could be worth looking at
# `rm -rf .local/share/zinit/snippets`
# zinit snippet OMZP::git
# zinit snippet OMZP::sudo
# zinit snippet OMZP::archlinux
# zinit snippet OMZP::aws
# zinit snippet OMZP::kubectl
# zinit snippet OMZP::kubectx
# zinit snippet OMZP::command-not-found

autoload -Uz compinit && compinit # Load completions
zinit cdreplay -q # Replay cached completions (recommended)
# }}

# [[ HISTORY ]] {{
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups
# }}

# [[ STYLING COMPLETIONS ]] {{
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
# zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'
# }}

# [[ SHELL INTEGRATIONS ]] {{
eval "$(fzf --zsh)"
# eval "$(zoxide init --cmd cd zsh)"
# }}

# [[ FZF CONFIGURATIONS ]] {{
# src: https://github.com/junegunn/fzf?tab=readme-ov-file#display-modes 
# https://github.com/junegunn/fzf/wiki/Configuring-shell-key-bindings
# https://github.com/junegunn/fzf?tab=readme-ov-file#tips
export FZF_TMUX_OPTS=" -p90%,80% "
export FZF_DEFAULT_COMMAND="fd --strip-cwd-prefix --hidden --follow --exclude '.git'"
# export FZF_DEFAULT_OPTS="--height 50% --layout reverse --border --color=hl:#7AA89F"
# export FZF_DEFAULT_OPTS="--height 80% --layout reverse --border --color=hl:#7AA89F --preview-window=right:60% --bind 'ctrl-d:preview-page-down' --bind 'ctrl-u:preview-page-up' --bind 'CTRL-O:toggle-preview-wrap'"
# NOTE: default layout puts searchbar in middle/bottom
export FZF_DEFAULT_OPTS="
  --height=80% --layout=reverse --border
  --preview-window=right:60%
  --bind='ctrl-d:preview-page-down,ctrl-u:preview-page-up,CTRL-O:toggle-preview-wrap'
  --color='dark,\
fg:#c5c8c6,\
fg+:#b5bd68:regular,\
hl:#f0c674,\
hl+:#cc6666,\
bg:#1d1f21,\
bg+:#43436c,\
gutter:-1,\
prompt:#9fb5c9,\
pointer:#f0c674,\
marker:#f0c674,\
info:#7AA89F,\
border:#81a2be,\
separator:#282a2e'
"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude '.git'"
# https://github.com/junegunn/fzf/wiki/Configuring-shell-key-bindings#ctrl-t
export FZF_CTRL_T_OPTS="--select-1 --exit-0 --preview 'bat --color=always -n --line-range :500 {}'"
export FZF_ALT_C_OPTS="--select-1 --exit-0 --preview 'eza --icons=always --tree --color=always {} | head -200'"
# export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"
# src: https://github.com/junegunn/fzf/wiki/Configuring-shell-key-bindings#full-command-on-preview-window
export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview'"
fzf-history-widget-accept() {
  fzf-history-widget
  zle accept-line
}
zle     -N     fzf-history-widget-accept
bindkey -r '^R' # unbind: https://unix.stackexchange.com/questions/285208/how-to-remove-a-zsh-keybinding-if-i-dont-know-what-it-does
bindkey '^R' fzf-history-widget-accept
# src: https://github.com/junegunn/fzf-git.sh
source ~/.dotfiles/scripts/.local/bin/scripts/fzf-git.sh
# INFO: use `bindkey -L` :) and `echo "CtrlVEsc/"`
# https://superuser.com/questions/169920/binding-fn-delete-in-zsh-on-mac-os-x/169930#169930
# ^G^B           # branches
# ^G^E           # each_ref
# ^G^F           # files
# ^G^H           # hashes
# ^G^L           # lreflogs
# ^G^R           # remotes
# ^G^S           # stashes
# ^G^T           # tags
# ^G^W           # worktrees
alias fgit='fzf-git.sh --run'
# }}

# [[ CUSTOM SCRIPTS ]] {{
# Keybindings
source ~/.dotfiles/scripts/.local/bin/scripts/set-vi-mode.sh
# SSH
source ~/.dotfiles/scripts/.local/bin/scripts/ssh.sh
# Fish-like abbrevations/expansions
source ~/.dotfiles/scripts/.local/bin/scripts/abbrev-alias.sh
# See ~/.config/systemd/user/ssh-agent.service
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
# }}

# [[ HELPER FUNCTIONS ]] {{
# # https://stackoverflow.com/questions/1314334/easy-way-to-create-a-file-nested-in-unavailable-directories/1314345#1314345
# mktouch {
#   mkdir -p "$(dirname $1)"
#   touch "$1"
# }
# # https://superuser.com/questions/1412808/add-function-to-zsh
# docker-clean() {
#   docker stop "$(docker ps -a -q)"
#   docker rm "$(docker ps -a -q)"
#   docker rmi "$(docker images -q)"
#   docker volume prune
# }
# }}

# [[ ABBREVIATIONS ]] {{
# [[ ESSENTIAL ]]
abbrev-alias v='nvim'
abbrev-alias getmeout="shutdown -h now"
abbrev-alias za="zathura"

# [[ QUICK NAVIGATION ]]
abbrev-alias cdracket="cd ~/Documents/cis-352/autograder-assignments/"
abbrev-alias cdsystems="cd ~/Documents/cis-384/"
abbrev-alias cdtest="cd ~/spaghetti/test/"
abbrev-alias cdnotes="cd ~/Documents/ObsidianNotes/"
abbrev-alias cdgit="cd ~/Documents/git_testing/"
abbrev-alias cdrs="cd ~/spaghetti/langs/rust/testing_grounds/"

# [[ PROJECT-SPECIFIC ]]
abbrev-alias cdip="cd ~/research-projects/seed-emulator/examples/internet/B28_traffic_generator/0-iperf-traffic-generator"
abbrev-alias cdlogs="cd /home/josh/research-projects/seed-emulator/examples/internet/B28_traffic_generator/0-iperf-traffic-generator/logs"
abbrev-alias cdbug="cd ~/repos/buildkit/control/gateway/"
# abbrev-alias s="source development.env && source seedenv/bin/activate"
abbrev-alias lsout='ls ./output | wc -l'

# [[ SHELL ]]
abbrev-alias watchdir="watch -g -n 0.1 ls"

# [[ GIT ]]
abbrev-alias g="git "

# [[ DOCKER ]]
abbrev-alias dc="docker compose"
abbrev-alias dcbuild="docker compose build"
abbrev-alias dcup="docker compose up"
# See https://docs.docker.com/reference/cli/docker/compose/up/ for more
abbrev-alias dcups="docker compose up --remove-orphans --abort-on-container-failure"

# [[ RUST ]]
abbrev-alias clipme='
cargo clippy -- \
-W clippy::pedantic \
-W clippy::nursery \
-W clippy::unwrap_used \
'

# [[ GO ]]
abbrev-alias gorun='ls *.go | entr -c go run /_' # e.g., rungo test.txt
# check for new available package updates
abbrev-alias gocheck="go list -u -f '{{if (and (not (or .Main .Indirect)) .Update)}}{{.Path}}: {{.Version}} -> {{.Update.Version}}{{end}}' -m all"

# [[ SQL ]]
alias mysql='mariadb'

# [[ TMUX ]]
abbrev-alias t="tmux"
abbrev-alias tnew="tmux new -s"
# }}

# [[ ALIASES ]] {{
# [[ SHELL ]]
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias s='source ~/.zshrc'
alias dot='cd ~/.dotfiles'
alias vz='nvim ~/.zshrc'
alias c='clear'
alias ls='ls --color=always -F'
alias l="eza --no-filesize --color=always --no-user --classify"
alias ll="eza --no-filesize --git --long --color=always --no-user --classify"
alias lla="eza -a --no-filesize --git --long --color=always --no-user --classify"
alias lll="eza --long --git --color=always --no-user --classify --tree --level=2"
alias cat='bat'
alias bat="bat --color=always --style=numbers,changes,header,grid --italic-text=always"
alias loc="tokei"
alias rmrf="kondo"
alias rm='rm -I'    # safety
alias mv='mv -iv'   # safety
# alias grep='rg'   # mental block :(
alias mdkir='mkdir' # i have a disability T_T
# alias vim='nvim'
alias ip='ip --color=auto'
alias path='echo $PATH | tr ":" "\n"'
alias pkg="pacman -Qq | fzf \
  --preview 'pacman -Qil {} | bat --style=full --color=always --language=yaml' \
  --preview-window=right:60%:wrap \
  --header='[PKG INFO] Press ENTER to view full details, ? for help' \
  --layout=reverse \
  --border=rounded \
  --info=inline \
  --height=80% \
  --bind 'enter:execute(pacman -Qil {} | bat --style=full --color=always --language=yaml | less -R)' \
  --bind 'ctrl-d:preview-page-down' \
  --bind 'ctrl-u:preview-page-up' \
  --bind '?:toggle-preview-wrap'"


# [[ "QOL" ]]
# alias f='fzf'
alias f='fzf --print0 | xargs -0 --no-run-if-empty -- nvim' # and ~/.dotfiles/scripts/ff :)
alias dim='wlsunset -s $(date +%H:%M) -t 4000 &'
alias pd='pushd'
alias vdiff='nvim -d'
alias py='python3'
alias tree="tree -L 3 -a -I '.git' --charset X "
alias minitree="tree -aL 3 --prune"
alias dirtree="tree -L 3 -a -d -I '.git' --charset X "
alias todo='nvim ~/misc/TODO.md'
alias hk='nvim ~/misc/hotkeys.md'
alias remind='nvim ~/misc/reminders.md'
alias qq='nvim ~/misc/blooms.md'
alias proompt='nvim ~/spaghetti/proompt.md'
alias sc='shellcheck'
alias btconnect='bluetoothctl connect BC:87:FA:BB:97:66'
alias souniq='sort | uniq -c'
alias text='shuf -n25 /usr/share/dict/american-english -o test.txt'
# https://www.reddit.com/r/golang/comments/uzrbw3/best_practice_do_you_use_the_go_compiler_from/
# TODO: hardcoded binary. See script in ~/.local/bin/scripts/goupdate
alias goupdate='sudo rm -rf /usr/local/go && curl -L https://go.dev/dl/go1.18.2.linux-amd64.tar.gz | sudo tar zx -C /usr/local/ go'

# [[ GRC (COLORIZED OUTPUT) ]]
alias go='grc go'
# }}

# [[ TESTING RANDOM IDEAS ]] {{
alias gitplay='cd ~/spaghetti/git_playground/'
# BAD: won't work b/c subshells. Script is called from some proc P, which spawns a child process C. When C returns control to P it's back where it was.
alias goplay='cd /tmp && (nvim main.go)'
alias vv='cd /tmp && (nvim random.md)'  # e.g., changelog for big commits
# }}

# [[ REFS ]] {{
# [[ SIMPLER SOLNS ]]
# bindkey -s ^v 'nvim ~/spaghetti/refs/**\t'
# bindkey -s '^v' 'nvim $(find ~/spaghetti/refs/ -type f | fzf --with-nth=-1 --delimiter=/)\n'

# [[ ONLY BASENAME ]]
# fzf-nvim-widget() {
#   local file
#   file=$(find ~/spaghetti/refs/ -type f | fzf --with-nth=-1 --delimiter=/) || return
#   [[ -n $file ]] && BUFFER="nvim $file" && zle accept-line
# }
# zle -N fzf-nvim-widget
# bindkey '^v' fzf-nvim-widget

# [[ INCLUDES DIRPATH ]]
fzf-nvim-widget() {
  local file
  file=$(find ~/spaghetti/refs -type f -printf "%P\n" | fzf) || return
  [[ -n $file ]] && BUFFER="nvim ~/spaghetti/refs/$file" && zle accept-line
}
zle -N fzf-nvim-widget
bindkey '^v' fzf-nvim-widget
# }}
