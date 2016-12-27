export ZSH=~/.oh-my-zsh

ZSH_THEME="robbyrussell"

plugins=(git)

source $ZSH/oh-my-zsh.sh

if [ "$(uname)" = "Darwin" ]; then  # Mac
  export JAVA_HOME=$(/usr/libexec/java_home)
  export PATH=/usr/local/Cellar/maven/3.3.9/bin:$PATH
  export MAVEN_OPTS="-Xss8M"
fi

alias python='python3'

typeset -U path path=(~/scripts $path)

# Adjust Vim gruvbox color scheme colors
# https://github.com/morhetz/gruvbox/wiki/Terminal-specific#a-256-color-gruvbox-palette-shellscript
source "$HOME/.config/nvim/plugged/gruvbox/gruvbox_256palette.sh"

# Virtualenvwrapper
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/devel
source /usr/local/bin/virtualenvwrapper.sh
