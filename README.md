# Instructions
Install prerequisites and `ln -s` config. There should be no missing dependencies if the list is followed from start to end.


## Terminal & Shell
Install `urxvt` with 256 colors support

 - Plugins: `urxvt-resize-font`
 - Font: `DejaVu Sans Mono Nerd Font`

`tmux`

 - `xclip` for clipboard
 - `bc` for compatibility mode configuration

`zsh` with `oh-my-zsh`

`the_silver_searcher` (ag)


## Development


### Python
`python` and `pip`

Install following pip packages:

 - Virtual environment: `virtualenv` and `virtualenvwrapper`
 - `python-language-server` (for Neovim)
 - Linting: `flake8`
 - Code formatting: `autopep8`


### JavaScript
`node` and `npm` and `zsh-nvm` (Oh My Zsh plugin)

Default global npm packages are in`$NVM_DIR/default-packages`


### Editor
`neovim` and `pynvim` (from pip) for Python support

`tig`


## UI
Theme
 - Xresources: `base16-xresources`
 - Shell: `base16-shell`
 - Editor: `base16-vim`

Wallpaper:
 - Generate with `ImageMagick`
 - Set with `feh`

Put `theme.sh` into `~/scripts` directory and use like this: `theme.sh <THEME>`
