#!/bin/bash

# TODO: clone_repo()
# clone with https (for a truly one-liner)

dotfiles_dir=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

is_package_installed() {
  pkg_command=$1
  command -v "$pkg_command" > /dev/null 2>&1
}

detect_os() {
  os=$( "$dotfiles_dir"/get_operating_system.sh )

  if [[ -z $os ]]; then
    echo >&2 "Unsupported operating system"
    exit 1
  fi
}

check_prerequisites() {
  has_prerequisites=1

  for pkg_command in git curl python3; do
    if ! is_package_installed "$pkg_command"; then
      echo >&2 "$pkg_command not found"
      has_prerequisites=0
    fi
  done

  if [[ $os == "arch_linux" ]]; then
    for pkg_command in sudo pacman pamac; do
      if ! is_package_installed "$pkg_command"; then
        echo >&2 "$pkg_command not found"
        has_prerequisites=0
      fi
    done
  fi

  # shellcheck disable=SC2016
  if [ -z "$($SHELL -c 'echo $ZSH_VERSION')" ]; then
    echo >&2 "Zsh is not default shell. Try to run chsh -s $(which zsh), https://github.com/ohmyzsh/ohmyzsh/wiki/Installing-ZSH#install-and-set-up-zsh-as-default"
    # NOTE: maybe check is zsh installed and try to make it default (requires password)
    has_prerequisites=0
  fi

  [ "$has_prerequisites" == 1 ]
}

install_brew() {
  if ! is_package_installed brew; then
    NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
    # Make Homebrew available by adding it to PATH. Added to .zprofile as well
    eval "$(/opt/homebrew/bin/brew shellenv)"
  fi
}

install_packages() {
  if [[ $os == "macos" ]]; then
    echo Install Homebrew...
    install_brew
    brew bundle --file="$dotfiles_dir"/Brewfile
  elif [[ $os == "arch_linux" ]]; then
    # TODO: Package names in packages-pacman.txt and packages-aur.txt are not verified on Arch Linux/Manjaro
    # shellcheck disable=SC2024
    sudo pacman -S --needed --noconfirm - < "$dotfiles_dir"/packages-pacman.txt

    mapfile -t aur_packages < "$dotfiles_dir"/packages-aur.txt
    for package in "${aur_packages[@]}"; do
      if pacman -Qq "$package" > /dev/null 2>&1; then
        echo "$package" already installed
      else
        pamac build --no-confirm "$package"
      fi
    done
  fi
}

link_dotfiles() {
  dotbot -d "$dotfiles_dir" -c "$dotfiles_dir"/install.conf.yaml
}

setup_oh_my_zsh() {
  if [ -d "$HOME"/.oh-my-zsh ]; then
    echo Oh My Zsh already installed
    return
  fi

  # Keep the linked .zshrc
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended --keep-zshrc
}

setup_node() {
  # NOTE: directory is $ZSH_CUSTOM
  zsh_nvm_dir=$HOME/.oh-my-zsh/custom/plugins/zsh-nvm

  # Install nvm manually, use it later via zsh-nvm
  # https://github.com/nvm-sh/nvm#manual-install
  if [ ! -d "$zsh_nvm_dir" ]; then
    git clone https://github.com/lukechilds/zsh-nvm "$zsh_nvm_dir"
  fi

  export NVM_DIR=${NVM_DIR:-$HOME/.nvm}

  # zsh-nvm installs nvm when loaded, if it is missing
  if [ ! -s "$NVM_DIR"/nvm.sh ]; then
    zsh -c "source \"$zsh_nvm_dir\"/zsh-nvm.plugin.zsh"
  fi

  # Make it available inside this script
  # shellcheck source=/dev/null
  source "$NVM_DIR"/nvm.sh

  ln -sfn "$dotfiles_dir"/nvm_default-packages "$NVM_DIR"/default-packages
  nvm install --lts
  nvm alias default 'lts/*'
}

setup_neovim_python() {
  # Configure Python for Neovim
  # https://neovim.io/doc/user/provider.html#python-virtualenv
  nvim_python_virtualenv_path=$HOME/.config/nvim/.py3nvim

  if [ ! -d "$nvim_python_virtualenv_path" ]; then
    python3 -m venv "$nvim_python_virtualenv_path"
  fi
  "$nvim_python_virtualenv_path"/bin/python3 -m pip install pynvim
}

setup_tinty() {
  # Initialize tinty (downloads schemes and templates)
  tinty sync
}

finish_installation() {
  echo "Complete. Run \"source ~/.zshenv && source ~/.zshrc && source ~/.zprofile\" or restart your terminal."
}

detect_os

echo Checking prerequisites...
if ! check_prerequisites; then
  exit 1
fi
echo OK
echo

echo Installing packages...
install_packages
echo OK
echo

echo Linking dotfiles...
link_dotfiles
echo OK
echo

echo Setting up Zsh...
setup_oh_my_zsh
echo OK
echo

echo Setting up Node.js...
setup_node
echo OK
echo

echo Setting up Neovim...
setup_neovim_python
echo OK
echo

echo Setting up UI...
setup_tinty
echo OK
echo

finish_installation
