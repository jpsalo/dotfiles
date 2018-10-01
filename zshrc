export ZSH=~/.oh-my-zsh

ZSH_THEME="robbyrussell"

# Loading nvm is unacceptably slow, but nvm is needed for vim
export NVM_LAZY_LOAD=false

plugins=(git zsh-nvm npm yarn)

source $ZSH/oh-my-zsh.sh

export EDITOR='nvim'

# https://www.sublimetext.com/docs/3/osx_command_line.html
export REACT_EDITOR='atom'

if [ "$(uname)" = "Darwin" ]; then  # Mac
  export JAVA_HOME=$(/usr/libexec/java_home)
  export PATH=/usr/local/Cellar/maven/3.3.9/bin:$PATH
  export MAVEN_OPTS="-Xss8M"
fi

# alias python='python3'

typeset -U path path=(~/scripts $path)


# 256 COLORS

# Adjust Vim gruvbox color scheme colors
# https://github.com/morhetz/gruvbox/wiki/Terminal-specific#a-256-color-gruvbox-palette-shellscript
# source "$HOME/.config/nvim/plugged/gruvbox/gruvbox_256palette.sh"

# Base16 256 colorspace
# https://github.com/chriskempson/base16-shell#bashzsh
# BASE16_SHELL=$HOME/.config/base16-shell/
# [ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"

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


# Virtualenvwrapper
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/devel
source /usr/local/bin/virtualenvwrapper.sh

# Fastlane
export PATH="$HOME/.fastlane/bin:$PATH"

# Android home for React Native command line interface
export ANDROID_HOME=~/Library/Android/sdk
export PATH=${PATH}:${ANDROID_HOME}/tools
export PATH=${PATH}:${ANDROID_HOME}/platform-tools


# https://github.com/neovim/neovim/wiki/FAQ#how-to-change-cursor-shape-in-the-terminal
# NOTE: This works differently on NeoVim >=0.2
# export NVIM_TUI_ENABLE_CURSOR_SHAPE=1


# Change iTerm2 color profile and set environment variable
# https://stackoverflow.com/a/38883860/7010222
# https://coderwall.com/p/s-2_nw/change-iterm2-color-profile-from-the-cli
theme-switch () { echo -e "\033]50;SetProfile=$1\a"; export ITERM_PROFILE=$1; }


# Fuzzy finder
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh


# Run Dropbox daemon
if type ~/scripts/dropbox-autostart.sh > /dev/null; then
	echo 'autostart'
	sh ~/scripts/dropbox-autostart.sh
fi
