# Dotfiles

Personal configuration for macOS and Arch Linux (i3), tuned for web development (JavaScript/TypeScript, Python).

## What's included

- **Shell:** Zsh with [Oh My Zsh](https://ohmyz.sh/), nvm via [zsh-nvm](https://github.com/lukechilds/zsh-nvm)
- **Terminal:** [Ghostty](https://ghostty.org/) with tmux (plugins via tpm)
- **Editor:** Neovim (`init.lua`, plugins via `vim.pack`, LSP via Mason, formatting via conform.nvim)
- **CLI tools:** git + delta, lazygit, fzf, ripgrep, bat, fd, yazi
- **Theming:** [tinty](https://github.com/tinted-theming/tinty) (base16/base24) for Ghostty, shell, tmux, fzf and delta
- **Linux only:** i3, i3status, Xresources, redshift

## Install

```sh
git clone https://github.com/jpsalo/dotfiles ~/dotfiles
cd ~/dotfiles
./install.sh
```

Prerequisites: `git`, `curl`, `python3`, and Zsh as the default shell (`chsh -s "$(which zsh)"`). On Arch Linux you also need `sudo`, `pacman` and `pamac`.

`install.sh` then:

1. Installs packages: on macOS from `Brewfile` (`brew bundle`), on Arch from `packages-pacman.txt` (official repos) and `packages-aur.txt` (AUR)
2. Links the dotfiles with [dotbot](https://github.com/anishathalye/dotbot), as declared in `install.conf.yaml`
3. Sets up Oh My Zsh, Node.js (nvm + LTS) and the Neovim Python virtualenv
4. Downloads tinty schemes and templates (`tinty sync`)

The installer is safe to rerun. Existing files at a link target are backed up as `*.dotbot-backup.*`.

When it finishes, restart the terminal or run `source ~/.zshenv && source ~/.zshrc && source ~/.zprofile`.

## Layout

Config files are in the repository root, named without the leading dot (for example `zshrc`, `gitconfig`, `tmux.conf`). Where each file is linked is declared in `install.conf.yaml`. Linux-only links are guarded with `if: '[ "$(uname)" = Linux ]'`.

## Themes

Themes are managed by tinty. The config is `tinty_config.toml`, and the schemes are listed in its `default` ring.

```sh
tinty apply base24-catppuccin-macchiato   # set a scheme
tinty cycle                               # step through the ring
```

`theme.sh` covers the X11/i3 parts that tinty doesn't handle yet (Linux only).

## Adding things

- macOS package: add it to `Brewfile`
- Arch package: add a line to `packages-pacman.txt` or `packages-aur.txt`
- New symlink: add an entry to `install.conf.yaml`

## License

[MIT](LICENSE)
