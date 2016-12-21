export ZSH=~/.oh-my-zsh

ZSH_THEME="sunaku"

plugins=(git)

export JAVA_HOME=$(/usr/libexec/java_home)
export PATH=/usr/local/Cellar/maven/3.3.9/bin:$PATH
export MAVEN_OPTS="-Xss8M"

source $ZSH/oh-my-zsh.sh

# Anaconda
# http://stackoverflow.com/a/24763637
export PATH="~/anaconda/bin:$PATH"

 # added for npm-completion https://github.com/Jephuff/npm-bash-completion
PATH_TO_NPM_COMPLETION="~/.nvm/versions/node/v6.4.0/lib/node_modules/npm-completion"
source $PATH_TO_NPM_COMPLETION/npm-completion.sh


# Base16 Shell colors
# https://github.com/chriskempson/base16-shell#bashzsh
BASE16_SHELL=$HOME/.config/base16-shell/
[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"

typeset -U path path=(~/scripts $path)

# Setting PATH for Python 3.5
# The original version is saved in .zprofile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.5/bin:${PATH}"
export PATH
