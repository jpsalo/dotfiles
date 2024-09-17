#!/bin/bash

# TODO: clone_repo()
# clone with https (for a truly one-liner)

# TODO: allow custom check
is_package_installed() {
  pkg_command=$1
  command -v "$pkg_command" > /dev/null 2>&1
}

# TODO: install_package()
# - allow custom install_command
# - is subdirectory?
# - backup
# - package name
# - configuration
# - destination
# - create symlink
# - callback
install_package() {
  package=$1

  if [ -z "$2" ]; then
    pkg_command=$package
  else
    pkg_command=$2
  fi

  if ! is_package_installed "$pkg_command"; then
    $install_command "$package"
  else
    echo "$package" already installed
  fi
}

install_cask_package() {
  package=$1
  brew install --cask "$package"
}

validate_directory() {
  node=$1
  mkdir -p "$node"
}

backup_existing_file() {
  file=$1

  if [ -f "$file" ] && [ ! -L "$file" ]; then
    mv "$file" "${file}".bak
  fi
}

create_symlink() {
  source_file=$HOME/dotfiles/$1

  if [ -z "$2" ]; then
    target_file=$HOME/.$1
  else
    target_file=$2
  fi

  ln -sfn "$source_file" "$target_file"
}

check_prerequisites() {
  has_prerequisites=1

  if ! is_package_installed git; then
    echo >&2 "Git not found"
    has_prerequisites=0
  fi

  if [ -z "$($SHELL -c 'echo $ZSH_VERSION')" ]; then
    echo >&2 "Zsh is not default shell. Try to run chsh -s $(which zsh), https://github.com/ohmyzsh/ohmyzsh/wiki/Installing-ZSH#install-and-set-up-zsh-as-default"
    # NOTE: maybe check is zsh installed and try to make it default (requires password)
    has_prerequisites=0
  fi

  echo "$has_prerequisites"
}

install_brew() {
  if ! is_package_installed brew; then
    NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
    # Make Homebrew available by adding it to PATH. Added to .zprofile as well
    eval "$(/opt/homebrew/bin/brew shellenv)"
  fi
}

configure_os_settings() {
  validate_directory "$HOME"/scripts
  create_symlink get_operating_system.sh "$HOME"/scripts/get_operating_system.sh
  os=$( "$HOME"/scripts/get_operating_system.sh )

  if [[ $os == "arch_linux" ]]; then
    install_command="sudo pacman -S" # TODO: --noconfirm
  elif [[ $os == "macos" ]]; then
    echo Install Homebrew...
    install_brew
    install_command="brew install"
  fi
}

setup_base_configuration() {
  validate_directory "$HOME"/.ssh
  backup_existing_file "$HOME"/ssh/config
  create_symlink ssh_config "$HOME"/.ssh/config

  validate_directory "$HOME"/.config/git
  backup_existing_file "$HOME"/.config/git/config
  create_symlink gitconfig "$HOME"/.config/git/config

  backup_existing_file "$HOME"/.gitignore # Probably best leave it here for root directory lookup
  create_symlink gitignore

  validate_directory "$HOME"/scripts
  create_symlink theme.sh "$HOME"/scripts/theme.sh

  backup_existing_file "$HOME"/.Xresources
  create_symlink Xresources

  validate_directory "$HOME"/.config/i3
  backup_existing_file "$HOME"/.config/i3/config
  create_symlink i3_config "$HOME"/.config/i3/config

  validate_directory "$HOME"/.config/i3status
  backup_existing_file "$HOME"/.config/i3status/config
  create_symlink i3status_config "$HOME"/.config/i3status/config

  install_package tmux
  validate_directory "$HOME"/.config/tmux
  backup_existing_file "$HOME"/.config/tmux/tmux.conf
  create_symlink tmux.conf "$HOME"/.config/tmux/tmux.conf

  install_package fzf

  install_package ripgrep rg

  install_package the_silver_searcher ag
  backup_existing_file "$HOME"/.ignore
  create_symlink ignore

  install_package tig
  validate_directory "$HOME"/.config/tig
  backup_existing_file "$HOME"/.config/tig/config
  create_symlink tigrc "$HOME"/.config/tig/config

  validate_directory "$HOME"/.config/bat
  install_package bat
  backup_existing_file "$HOME"/.config/bat/config
  create_symlink bat_config "$HOME"/.config/bat/config
}

setup_terminal() {
  if [[ $os == "macos" ]]; then
    is_iterm_installed=false
    if brew list iterm2 &>/dev/null; then
      is_iterm_installed=true
    fi

    install_cask_package iterm2

    validate_directory "$HOME"/.config/iterm
    backup_existing_file "$HOME"/.config/iterm/com.googlecode.iterm2.plist
    create_symlink com.googlecode.iterm2.plist "$HOME"/.config/iterm/com.googlecode.iterm2.plist

    if [ "$is_iterm_installed" = false ] ; then
      # It looks like apps need to be run before the settings can be persisted.
      # Do not do this if iTerm2 is already installed.
      echo iTerm2 will now open. Please quit it to continue the installation. If it does not open automatically, then run it manually.
      open -W -a iTerm
    fi

    # Specify the preferences directory
    defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string "~/.config/iterm/"
    # Tell iTerm2 to use the custom preferences in the directory
    defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder -bool true
  fi
}

setup_zsh() {
  # Install Oh My Zsh
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

  backup_existing_file "$HOME"/.zshrc
  create_symlink zshrc

  backup_existing_file "$HOME"/.zshenv
  create_symlink zshenv

  backup_existing_file "$HOME"/.zprofile
  create_symlink zprofile
}

setup_python() {

  if [[ $os == "arch_linux" ]]; then
    install_package python
  elif [[ $os == "macos" ]]; then
    # TODO: as is_package_installed custom check
    # TODO: as custom install_command for install_package
    brew list python || brew install python
  fi
}

setup_node() {
  install_package node

  # Install nvm manually, use it later via zsh-nvm
  # https://github.com/nvm-sh/nvm#manual-install

  # NOTE: directory is $ZSH_CUSTOM
  git clone https://github.com/lukechilds/zsh-nvm "$HOME"/.oh-my-zsh/custom/plugins/zsh-nvm
  # Make it available inside this script
  source "$NVM_DIR"/nvm.sh

  # NOTE: Not needed with zsh-nvm
  # export NVM_DIR="$HOME/.nvm" && (
  #   git clone https://github.com/nvm-sh/nvm.git "$NVM_DIR"
  #   cd "$NVM_DIR"
  #   git checkout `git describe --abbrev=0 --tags --match "v[0-9]*" $(git rev-list --tags --max-count=1)`
  # ) && \. "$NVM_DIR/nvm.sh"

  create_symlink nvm_default-packages "$NVM_DIR"/default-packages
  nvm install --lts
  nvm alias default lts/*
}

setup_neovim() {
  install_package neovim nvim

  # Configure Python for Neovim
  # https://neovim.io/doc/user/provider.html#python-virtualenv
  python3 -m venv ~/.config/nvim/.py3nvim
  source ~/.config/nvim/.py3nvim/bin/activate
  python3 -m pip install pynvim
  deactivate

  if [[ $os == "arch_linux" ]]; then
    if ! is_package_installed ctags; then
      # https://github.com/universal-ctags/ctags/blob/master/docs/autotools.rst
      # TODO: check if package is installed
      install_package python-docutils
      validate_directory "$HOME"/bin
      validate_directory "$HOME"/lib
      git clone https://github.com/universal-ctags/ctags.git "$HOME"/lib/universal-ctags
      (
        cd "$HOME"/lib/universal-ctags || exit
        ./autogen.sh
        ./configure --prefix="$HOME"
        make
        make install
      )
    fi
  elif [[ $os == "macos" ]]; then
    brew install universal-ctags
  fi

  validate_directory "$HOME"/.config/nvim
  backup_existing_file "$HOME"/.config/nvim/init.lua
  create_symlink init.lua "$HOME"/.config/nvim/init.lua

  backup_existing_file "$HOME"/.editorconfig
  create_symlink editorconfig
}

setup_ui() {
  # https://github.com/tinted-theming/tinted-shell/blob/main/USAGE.md#installation
  git clone https://github.com/tinted-theming/tinted-shell.git "$HOME"/.config/tinted-theming/tinted-shell
  "$HOME"/scripts/theme.sh dark

  if [[ $os == "arch_linux" ]]; then
    linux_fonts=ttf-sourcecodepro-nerd
    linux_fonts_fallback=ttf-dejavu-nerd

    # TODO: as is_package_installed custom check
    if pacman -Qi $linux_fonts > /dev/null 2>&1; then
      echo $linux_fonts already installed
    else
      # TODO: as custom install_command for install_package
      pamac build $linux_fonts # TODO: --no-confirm
    fi

    # TODO: as is_package_installed custom check
    if pacman -Qi $linux_fonts_fallback > /dev/null 2>&1; then
      echo $linux_fonts_fallback already installed
    else
      # TODO: as custom install_command for install_package
      pamac build "$linux_fonts_fallback"  # TODO: --no-confirm
    fi

  elif [[ $os == "macos" ]]; then
    install_cask_package font-sauce-code-pro-nerd-font
  fi
}

finish_installation() {
  echo "Complete. Run \"source ~/.zshenv && source ~/.zshrc && source ~/.zprofile\" or restart your terminal."
  exit 0
}

echo Checking prerequisites...
has_prerequisites=$( check_prerequisites )
if [ "$has_prerequisites" == 0 ]; then
  exit 1
else
  echo OK
fi
echo

echo Configuring OS-specific settings...
configure_os_settings
echo OK
echo

echo Setting up the base...
setup_base_configuration
echo OK
echo

echo Setting up terminal...
setup_terminal
echo OK

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
