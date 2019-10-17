export ZSH=~/.oh-my-zsh

ZSH_THEME="robbyrussell"

plugins=(git npm pip colored-man-pages tmux)

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
# https://github.com/base16-manager/base16-manager#notes
BASE16_SHELL=$HOME/.local/share/base16-manager/chriskempson/base16-shell/
[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"

# Fuzzy finder
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# https://virtualenvwrapper.readthedocs.io/en/latest/install.html#python-interpreter-virtualenv-and-path
export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/devel

if [ -f /usr/bin/virtualenvwrapper.sh ]
then
  source /usr/bin/virtualenvwrapper.sh
elif [ -f $HOME/.local/bin/virtualenvwrapper.sh ]
then
  source $HOME/.local/bin/virtualenvwrapper.sh
fi

# The next line updates PATH for the Google Cloud SDK.
if [ -f $HOME/bin/google-cloud-sdk/path.zsh.inc ]; then . $HOME/bin/google-cloud-sdk/path.zsh.inc; fi

# The next line enables shell command completion for gcloud.
if [ -f $HOME/bin/google-cloud-sdk/completion.zsh.inc ]; then . $HOME/bin/google-cloud-sdk/completion.zsh.inc; fi

if [ -f $HOME/.google-service-account.json ]
then
  export GOOGLE_APPLICATION_CREDENTIALS="$(< $HOME/.google-service-account.json)"
fi

export PATH=$HOME/bin/mongodb/bin:$PATH
export PATH=$HOME/bin/splunk/bin:$PATH
