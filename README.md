# Instructions
Clone this repository and run `install.sh`.

On macOS, packages, casks and taps come from `Brewfile` (installed via `brew bundle`). Arch Linux packages are listed in `packages-pacman.txt` (official repos) and `packages-aur.txt` (AUR), one per line.

Symlinks are declared in `install.conf.yaml` and created by [dotbot](https://github.com/anishathalye/dotbot). Existing files at a link target are backed up as `*.dotbot-backup.*`. The installer can be rerun safely.
