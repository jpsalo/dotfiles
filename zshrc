export ZSH=~/.oh-my-zsh

ZSH_THEME="robbyrussell"

plugins=(git npm pip)

source $ZSH/oh-my-zsh.sh

export EDITOR='nvim'

alias python='python3'

# Executables
export PATH=$HOME/.local/bin:$PATH
export PATH="$HOME/bin:$PATH"
typeset -U path path=(~/scripts $path)

# Manually change npm’s default directory
# https://docs.npmjs.com/resolving-eacces-permissions-errors-when-installing-packages-globally#manually-change-npms-default-directory
export PATH=~/.npm-global/bin:$PATH

# Base16 Shell
# https://github.com/chriskempson/base16-shell#bashzsh
BASE16_SHELL=$HOME/.config/base16-shell/
[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"

# https://github.com/neovim/neovim/wiki/FAQ#how-to-change-cursor-shape-in-the-terminal
# NOTE: This works differently on NeoVim >=0.2
# export NVIM_TUI_ENABLE_CURSOR_SHAPE=1


# Fuzzy finder
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
