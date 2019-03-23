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

# Base16 256 colorspace
# https://github.com/chriskempson/base16-shell#bashzsh
BASE16_SHELL=$HOME/.config/base16-shell/
[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"

# Base16 Shell
# https://github.com/kristijanhusak/vim-hybrid-material/tree/master/base16-material#setup

# if [[ -z "${ITERM_PROFILE}" ]]; then
#   BASE16_SHELL="$HOME/.config/base16-shell/base16-material.dark.sh"
# else
#   if [ "$ITERM_PROFILE" = "light" ]; then
#     BASE16_SHELL="$HOME/.config/base16-shell/base16-material.light.sh"
#   else
#     BASE16_SHELL="$HOME/.config/base16-shell/base16-material.dark.sh"
#   fi
# fi
#
# [[ -s $BASE16_SHELL ]] && source $BASE16_SHELL


# https://github.com/neovim/neovim/wiki/FAQ#how-to-change-cursor-shape-in-the-terminal
# NOTE: This works differently on NeoVim >=0.2
# export NVIM_TUI_ENABLE_CURSOR_SHAPE=1


# Change iTerm2 color profile and set environment variable
# https://stackoverflow.com/a/38883860/7010222
# https://coderwall.com/p/s-2_nw/change-iterm2-color-profile-from-the-cli
# theme-switch () { echo -e "\033]50;SetProfile=$1\a"; export ITERM_PROFILE=$1; }


# Fuzzy finder
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
