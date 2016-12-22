export ZSH=~/.oh-my-zsh

ZSH_THEME="robbyrussell"

plugins=(git)

source $ZSH/oh-my-zsh.sh

if [ -f /usr/libexec/java_home ];
then
  export JAVA_HOME=$(/usr/libexec/java_home)
  export PATH=/usr/local/Cellar/maven/3.3.9/bin:$PATH
  export MAVEN_OPTS="-Xss8M"
fi

alias python='python3'

# Anaconda
# http://stackoverflow.com/a/24763637
#export PATH="~/anaconda/bin:$PATH"

typeset -U path path=(~/scripts $path)

# Adjust Vim gruvbox color scheme colors
# https://github.com/morhetz/gruvbox/wiki/Terminal-specific#a-256-color-gruvbox-palette-shellscript
source "$HOME/.config/nvim/plugged/gruvbox/gruvbox_256palette.sh"
