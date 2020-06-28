#!/bin/bash

# TODO: OS install command
# - macOS, brew
# - Arch, sudo pacman -S

# TODO: clone_repo()
# clone with https (for a truly one-liner)

is_package_installed() {
  package=$1
  is_installed=0

  if command -v $package &> /dev/null; then
    is_installed=1
  fi

  echo "$is_installed"
}

# TODO: install_package()
# - package name
# - configuration
# - destination
install_package() {
  package=$1

  if [ ! $( is_package_installed $package ) ]; then
    brew install $package
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
  source_file=$1
  target_file=$2

  ln -sfn $source_file $target_file
}

check_prerequisites() {
  has_prerequisites=1

  if [ ! $( is_package_installed git ) ]; then
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
  if [ ! $( is_package_installed brew ) ]; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
  fi
}

setup_base_configuration() {
  validate_directory ~/.ssh
  backup_existing_file ~/ssh/config
  create_symlink ~/dotfiles/ssh_config ~/.ssh/config

  backup_existing_file ~/.gitconfig
  create_symlink ~/dotfiles/gitconfig ~/.gitconfig

  validate_directory ~/scripts
  create_symlink ~/dotfiles/theme.sh ~/scripts/theme.sh

  backup_existing_file ~/.zshenv
  create_symlink ~/dotfiles/zshenv ~/.zshenv

  backup_existing_file ~/.Xresources
  create_symlink ~/dotfiles/Xresources ~/.Xresources

  install_package tmux
  backup_existing_file ~/tmux.conf
  create_symlink ~/dotfiles/tmux.conf ~/.tmux.conf

  install_package the_silver_searcher
  backup_existing_file ~/.ignore
  create_symlink ~/dotfiles/ignore ~/.ignore

  install_package tig
  backup_existing_file ~/.tigrc
  create_symlink ~/dotfiles/tigrc ~/.tigrc
}

setup_zsh() {
  # Install Oh My Zsh
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

  backup_existing_file ~/.zshrc
  create_symlink ~/dotfiles/zshrc ~/.zshrc
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
  if [ ! $( is_package_installed node ) ]; then
    brew install node
  fi

  # Install nvm manually, use it later via zsh-nvm
  # https://github.com/nvm-sh/nvm#manual-install

  # NOTE: directory is $ZSH_CUSTOM
  git clone https://github.com/lukechilds/zsh-nvm ~/.oh-my-zsh/custom/plugins/zsh-nvm

  export NVM_DIR="$HOME/.nvm" && (
    git clone https://github.com/nvm-sh/nvm.git "$NVM_DIR"
    cd "$NVM_DIR"
    git checkout `git describe --abbrev=0 --tags --match "v[0-9]*" $(git rev-list --tags --max-count=1)`
  ) && \. "$NVM_DIR/nvm.sh"

  create_symlink ~/dotfiles/nvm_default-packages $NVM_DIR/default-packages
  nvm install --lts
}

setup_neovim() {
  if [ ! $( is_package_installed node ) ]; then
    brew install neovim
  fi

  mkvirtualenv py3nvim -i pynvim && deactivate

  validate_directory ~/.config/nvim
  backup_existing_file ~/.config/nvim/init.vim
  backup_existing_file ~/.config/nvim/coc-settings.json
  create_symlink ~/dotfiles/init.vim ~/.config/nvim/init.vim
  create_symlink ~/dotfiles/coc-settings.json ~/.config/nvim/coc-settings.json

  backup_existing_file ~/.editorconfig
  backup_existing_file ~/.eslintrc
  backup_existing_file ~/.tern-project
  create_symlink ~/dotfiles/editorconfig ~/.editorconfig
  create_symlink ~/dotfiles/eslintrc.js ~/.eslintrc.js
  create_symlink ~/dotfiles/tern-project ~/.tern-project
}

setup_ui() {
  git clone https://github.com/chriskempson/base16-shell.git ~/.config/base16-shell
  ~/scripts/theme.sh dark

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

echo Install Homebrew
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

echo Setting up Python...
setup_python
echo OK
echo

echo Setting up node...
setup_node
echo OK
echo

echo Setting up Neovim...
setup_neovim
echo OK
echo

echo Setting up UI
setup_ui
echo OK
echo

finish_installation
