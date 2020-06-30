#!/bin/bash

# TODO: OS install command
# - macOS, brew
# - Arch, sudo pacman -S
alias install_command='brew install'

# TODO: clone_repo()
# clone with https (for a truly one-liner)

is_package_installed() {
  pkg_command=$1
  command -v "$pkg_command" >/dev/null 2>&1
}

# TODO: install_package()
# - package name
# - configuration
# - destination
install_package() {
  package=$1

  if [ -z "$2" ]; then
    pkg_command=$1
  else
    pkg_command=$2
  fi

  if ! is_package_installed $pkg_command; then
    $install_command $package
  else
    echo $package already installed
  fi
}

validate_directory() {
  node=$1
  mkdir -p $node
}

backup_existing_file() {
  file=$1

  if [ -f "$file" ] && [ ! -L $file ]; then
    mv $file ${file}.bak
  fi
}

create_symlink() {
  source_file=$HOME/dotfiles/$1

  if [ -z "$2" ]; then
    target_file=$HOME/.$1
  else
    target_file=$2
  fi

  ln -sfn $source_file $target_file
}

check_prerequisites() {
  has_prerequisites=1

  if ! is_package_installed git; then
    echo >&2 "Git not found"
    has_prerequisites=0
  fi

  if [ -z "`$SHELL -c 'echo $ZSH_VERSION'`" ]; then
    echo >&2 "Zsh is not default shell"
    # NOTE: maybe check is zsh installed and try to make it default (requires password)
    has_prerequisites=0
  fi

  echo "$has_prerequisites"
}

install_brew() {
  if ! is_package_installed brew; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
  fi
}

setup_base_configuration() {
  validate_directory $HOME/.ssh
  backup_existing_file $HOME/ssh/config
  create_symlink ssh_config $HOME/.ssh/config

  backup_existing_file $HOME/.gitconfig
  create_symlink gitconfig

  validate_directory $HOME/scripts
  create_symlink theme.sh $HOME/scripts/theme.sh

  backup_existing_file $HOME/.zshenv
  create_symlink zshenv

  backup_existing_file $HOME/.Xresources
  create_symlink Xresources

  install_package tmux
  backup_existing_file $HOME/tmux.conf
  create_symlink tmux.conf

  install_package the_silver_searcher ag
  backup_existing_file $HOME/.ignore
  create_symlink ignore

  install_package tig
  backup_existing_file $HOME/.tigrc
  create_symlink tigrc
}

setup_zsh() {
  # Install Oh My Zsh
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

  backup_existing_file $HOME/.zshrc
  create_symlink zshrc
}

setup_python() {
  # Installing Python 3 here
  # TODO: The many ways to check
  brew list python || brew install python

  # NOTE: virtualenv & virtualenvwrapper need to be in same global site-packages area
  # TODO: use requirements.txt

  python3 -m pip install virtualenv
  python3 -m pip install virtualenvwrapper

  # Make it available inside this script
  # https://stackoverflow.com/a/7539449
  source `which virtualenvwrapper.sh`

  python3 -m pip install python-language-server
  python3 -m pip install flake8
  python3 -m pip install --upgrade autopep8
}

setup_node() {
  install_package node

  # Install nvm manually, use it later via zsh-nvm
  # https://github.com/nvm-sh/nvm#manual-install

  # NOTE: directory is $ZSH_CUSTOM
  git clone https://github.com/lukechilds/zsh-nvm $HOME/.oh-my-zsh/custom/plugins/zsh-nvm

  export NVM_DIR="$HOME/.nvm" && (
    git clone https://github.com/nvm-sh/nvm.git "$NVM_DIR"
    cd "$NVM_DIR"
    git checkout `git describe --abbrev=0 --tags --match "v[0-9]*" $(git rev-list --tags --max-count=1)`
  ) && \. "$NVM_DIR/nvm.sh"

  create_symlink nvm_default-packages $NVM_DIR/default-packages
  nvm install --lts
}

setup_neovim() {
  install_package neovim nvim
  mkvirtualenv py3nvim -i pynvim && deactivate

  validate_directory $HOME/.config/nvim
  backup_existing_file $HOME/.config/nvim/init.vim
  backup_existing_file $HOME/.config/nvim/coc-settings.json
  create_symlink init.vim $HOME/.config/nvim/init.vim
  create_symlink coc-settings.json $HOME/.config/nvim/coc-settings.json

  backup_existing_file $HOME/.editorconfig
  backup_existing_file $HOME/.eslintrc
  backup_existing_file $HOME/.tern-project
  create_symlink editorconfig
  create_symlink eslintrc.js
  create_symlink tern-project
}

setup_ui() {
  git clone https://github.com/chriskempson/base16-shell.git $HOME/.config/base16-shell
  $HOME/scripts/theme.sh dark

  brew tap homebrew/cask-fonts
  brew cask install font-hack-nerd-font
}

finish_installation() {
  echo "Complete. Run \"source ~/.zshenv && source ~/.zshrc\" or restart your terminal."
  exit 0
}

echo Checking prerequisites...
has_prerequisites=$( check_prerequisites )
if [ $has_prerequisites == 0 ]; then
  exit 1
else
  echo OK
fi
echo

echo Install Homebrew...
install_brew
echo OK
echo

echo Setting up the base...
setup_base_configuration
echo OK
echo

echo Setting up Zsh...
setup_zsh
echo OK
echo

echo Setting up Python 3...
setup_python
echo OK
echo

echo Setting up Node.js...
setup_node
echo OK
echo

echo Setting up Neovim...
setup_neovim
echo OK
echo

echo Setting up UI...
setup_ui
echo OK
echo

finish_installation
