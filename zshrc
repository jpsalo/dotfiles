export ZSH=~/.oh-my-zsh

ZSH_THEME="robbyrussell"

plugins=(git)

source $ZSH/oh-my-zsh.sh

export EDITOR='nvim'

if [ "$(uname)" = "Darwin" ]; then  # Mac
  export JAVA_HOME=$(/usr/libexec/java_home)
  export PATH=/usr/local/Cellar/maven/3.3.9/bin:$PATH
  export MAVEN_OPTS="-Xss8M"
fi

alias python='python3'

typeset -U path path=(~/scripts $path)


# 256 COLORS

# Adjust Vim gruvbox color scheme colors
# https://github.com/morhetz/gruvbox/wiki/Terminal-specific#a-256-color-gruvbox-palette-shellscript
# source "$HOME/.config/nvim/plugged/gruvbox/gruvbox_256palette.sh"

# Base16 256 colorspace
# https://github.com/chriskempson/base16-shell#bashzsh
BASE16_SHELL=$HOME/.config/base16-shell/
[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"


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
