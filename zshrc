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

# Fuzzy finder
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# https://virtualenvwrapper.readthedocs.io/en/latest/install.html#python-interpreter-virtualenv-and-path
export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/devel
source $HOME/.local/bin/virtualenvwrapper.sh

# The next line updates PATH for the Google Cloud SDK.
if [ -f $HOME/bin/google-cloud-sdk/path.zsh.inc ]; then . $HOME/bin/google-cloud-sdk/path.zsh.inc; fi

# The next line enables shell command completion for gcloud.
if [ -f $HOME/bin/google-cloud-sdk/completion.zsh.inc ]; then . $HOME/bin/google-cloud-sdk/completion.zsh.inc; fi

export GOOGLE_APPLICATION_CREDENTIALS="$(< $HOME/.google-service-account.json)"
