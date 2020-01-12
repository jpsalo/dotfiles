export ZSH=~/.oh-my-zsh

ZSH_THEME="robbyrussell"

plugins+=(zsh-nvm)

plugins+=(
  colored-man-pages
  git
  npm
  pip
  tmux
  yarn
  virtualenvwrapper
)

# Base16 Shell
# https://github.com/chriskempson/base16-shell#bashzsh
BASE16_SHELL="$HOME/.config/base16-shell/"
[ -n "$PS1" ] && \
    [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
        eval "$("$BASE16_SHELL/profile_helper.sh")"

ZSH_TMUX_AUTOSTART=true
ZSH_TMUX_AUTOQUIT=false

source $ZSH/oh-my-zsh.sh

alias python='python3'
alias pip=pip3

# Fuzzy finder
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# https://virtualenvwrapper.readthedocs.io/en/latest/install.html#python-interpreter-virtualenv-and-path
export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/devel

# The next line updates PATH for the Google Cloud SDK.
if [ -f $HOME/bin/google-cloud-sdk/path.zsh.inc ]; then . $HOME/bin/google-cloud-sdk/path.zsh.inc; fi

# The next line enables shell command completion for gcloud.
if [ -f $HOME/bin/google-cloud-sdk/completion.zsh.inc ]; then . $HOME/bin/google-cloud-sdk/completion.zsh.inc; fi

if [ -f $HOME/.google-service-account.json ]
then
  export GOOGLE_APPLICATION_CREDENTIALS="$(< $HOME/.google-service-account.json)"
fi

# nvm completion
# https://github.com/nvm-sh/nvm#bash-completion
[[ -r $NVM_DIR/bash_completion ]] && \. $NVM_DIR/bash_completion
