export ZSH=~/.oh-my-zsh

ZSH_THEME="robbyrussell"

plugins=(git)

export JAVA_HOME=$(/usr/libexec/java_home)
export PATH=/usr/local/Cellar/maven/3.3.9/bin:$PATH
export MAVEN_OPTS="-Xss8M"

source $ZSH/oh-my-zsh.sh

alias python='python3'

# Anaconda
# http://stackoverflow.com/a/24763637
#export PATH="~/anaconda/bin:$PATH"

# Base16 Shell colors
# https://github.com/chriskempson/base16-shell#bashzsh
BASE16_SHELL=$HOME/.config/base16-shell/
[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"

typeset -U path path=(~/scripts $path)

# Adjust Vim gruvbox color scheme colors
# https://github.com/morhetz/gruvbox/wiki/Terminal-specific#a-256-color-gruvbox-palette-shellscript
source "$HOME/.config/nvim/plugged/gruvbox/gruvbox_256palette.sh"
