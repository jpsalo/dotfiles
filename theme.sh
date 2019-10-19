#!/bin/bash

# https://github.com/chriskempson/base16-shell/issues/126#issuecomment-409990674
BASE16_SHELL=$HOME/.config/base16-shell/
[ -s $BASE16_SHELL/profile_helper.sh ] && \
              eval "$($BASE16_SHELL/profile_helper.sh)"

DEFAULT_DARK="oceanicnext"
DEFAULT_LIGHT="solarized-light"

set_theme() {
  theme=$1

  xresources_theme="https://raw.githubusercontent.com/chriskempson/base16-xresources/master/xresources/base16-${theme}-256.Xresources"
  curl $xresources_theme > ~/.Xresources.d/colors
  xrdb -load -I$HOME ~/.Xresources

  i3-msg reload

  shell_theme=${HOME}/.config/base16-shell/scripts/base16-${theme}.sh
  _base16 $shell_theme $theme
}

set_wallpaper() {
  bg=$(xrdb -query | grep "*background" | cut -f 2)

  color1=$(xrdb -query | grep "*color1" | cut -f 2)
  color2=$(xrdb -query | grep "*color2" | cut -f 2)
  color3=$(xrdb -query | grep "*color3" | cut -f 2)
  color4=$(xrdb -query | grep "*color4" | cut -f 2)
  color5=$(xrdb -query | grep "*color5" | cut -f 2)
  color6=$(xrdb -query | grep "*color6" | cut -f 2)
  color7=$(xrdb -query | grep "*color7" | cut -f 2)
  color8=$(xrdb -query | grep "*color8" | cut -f 2)
  color9=$(xrdb -query | grep "*color9" | cut -f 2)
  color10=$(xrdb -query | grep "*color10" | cut -f 2)
  color11=$(xrdb -query | grep "*color11" | cut -f 2)
  color12=$(xrdb -query | grep "*color12" | cut -f 2)
  color13=$(xrdb -query | grep "*color13" | cut -f 2)
  color14=$(xrdb -query | grep "*color14" | cut -f 2)
  color15=$(xrdb -query | grep "*color15" | cut -f 2)
  color16=$(xrdb -query | grep "*color16" | cut -f 2)
  color17=$(xrdb -query | grep "*color17" | cut -f 2)
  color18=$(xrdb -query | grep "*color18" | cut -f 2)
  color19=$(xrdb -query | grep "*color19" | cut -f 2)
  color20=$(xrdb -query | grep "*color20" | cut -f 2)
  color21=$(xrdb -query | grep "*color21" | cut -f 2)

  convert -size 1920x1080 xc:$bg \
     -draw "fill '$color1'  rectangle 50,   100   100,  150"  \
     -draw "fill '$color2'  rectangle 100,  100   150,  150"  \
     -draw "fill '$color3'  rectangle 150,  100   200,  150"  \
     -draw "fill '$color4'  rectangle 200,  100   250,  150"  \
     -draw "fill '$color5'  rectangle 250,  100   300,  150"  \
     -draw "fill '$color6'  rectangle 300,  100   350,  150"  \
     -draw "fill '$color7'  rectangle 350,  100   400,  150"  \
  \
     -draw "fill '$color8'  rectangle 50,   150   100,  200"  \
     -draw "fill '$color9'  rectangle 100,  150   150,  200"  \
     -draw "fill '$color10' rectangle 150,  150   200,  200"  \
     -draw "fill '$color11' rectangle 200,  150   250,  200"  \
     -draw "fill '$color12' rectangle 250,  150   300,  200"  \
     -draw "fill '$color13' rectangle 300,  150   350,  200"  \
     -draw "fill '$color14' rectangle 350,  150   400,  200"  \
  \
     -draw "fill '$color15' rectangle 50,   200   100,  250" \
     -draw "fill '$color16' rectangle 100,  200   150,  250" \
     -draw "fill '$color17' rectangle 150,  200   200,  250" \
     -draw "fill '$color18' rectangle 200,  200   250,  250" \
     -draw "fill '$color19' rectangle 250,  200   300,  250" \
     -draw "fill '$color20' rectangle 300,  200   350,  250" \
     -draw "fill '$color21' rectangle 350,  200   400,  250" \
     $HOME/.wallpaper.png

  feh --bg-scale $HOME/.wallpaper.png
}

if [ "$1" = "dark" ]; then
  set_theme $DEFAULT_DARK
elif [ "$1" = "light" ]; then
  set_theme $DEFAULT_LIGHT
else
  set_theme $1
fi

set_wallpaper
