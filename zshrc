export ZSH=~/.oh-my-zsh

ZSH_THEME="robbyrussell"

# NOTE: directory is $ZSH_CUSTOM
if [ -d ~/.oh-my-zsh/custom/plugins/zsh-nvm ]; then
  # Auto use node version specified in directory's .nvmrc file
  # https://github.com/lukechilds/zsh-nvm#auto-use
  export NVM_AUTO_USE=true
  export NVM_COMPLETION=true
  plugins+=(zsh-nvm)
fi

plugins+=(
  colored-man-pages
  extract
  git
  ng
  npm
  pip
  tmux
  yarn
  virtualenv
)

# NOTE: Tinty shell completion: https://github.com/tinted-theming/tinty/blob/main/USAGE.md#shell-completions
# if [ -f $HOME/bin/tinty-zsh-completion.sh ]; then . $HOME/bin/tinty-zsh-completion.sh; fi

ZSH_TMUX_AUTOSTART=true
ZSH_TMUX_AUTOQUIT=false

source $ZSH/oh-my-zsh.sh

alias python='python3'
alias pip=pip3

# Set up fzf key bindings and fuzzy completion
[ -f ~/.fzf.zsh ] && source <(fzf --zsh)

# The next line updates PATH for the Google Cloud SDK.
if [ -f $HOME/bin/google-cloud-sdk/path.zsh.inc ]; then . $HOME/bin/google-cloud-sdk/path.zsh.inc; fi

# The next line enables shell command completion for gcloud.
if [ -f $HOME/bin/google-cloud-sdk/completion.zsh.inc ]; then . $HOME/bin/google-cloud-sdk/completion.zsh.inc; fi

if [ -f $HOME/.google-service-account.json ]
then
  export GOOGLE_APPLICATION_CREDENTIALS="$(< $HOME/.google-service-account.json)"
fi

# NOTE: not needed. Handled by zsh-nvm
# nvm completion
# https://github.com/nvm-sh/nvm#bash-completion
# [[ -r $NVM_DIR/bash_completion ]] && \. $NVM_DIR/bash_completion

# Load Angular CLI autocompletion.
# https://angular.io/cli/completion
source <(ng completion script)

# Show virtualenv in prompt
# https://stackoverflow.com/a/42287807/7010222
export VIRTUAL_ENV_DISABLE_PROMPT=

[ -f ~/.env ] && source ~/.env
