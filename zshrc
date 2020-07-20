export ZSH=~/.oh-my-zsh

ZSH_THEME="robbyrussell"

# NOTE: directory is $ZSH_CUSTOM
if [ -d ~/.oh-my-zsh/custom/plugins/zsh-nvm ]; then
  # Auto use node version specified in directory's .nvmrc file
  # https://github.com/lukechilds/zsh-nvm#auto-use
  export NVM_AUTO_USE=true
  plugins+=(zsh-nvm)
fi

plugins+=(
  colored-man-pages
  git
  ng
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
# NOTE: System Python path is not the same on Linux and on macOS
export VIRTUALENVWRAPPER_PYTHON=`which python3`
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

# Run global ESLint with personal configuration file and find the plugins from nvm's npm packages
# https://eslint.org/docs/user-guide/configuring#personal-configuration-file-deprecated
# https://eslint.org/docs/user-guide/command-line-interface
alias eslint='eslint --config $HOME/.eslintrc.js --resolve-plugins-relative-to $(npm root -g)'
