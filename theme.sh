#!/bin/bash

# Setting themes from within bash scripts
# https://github.com/chriskempson/base16-shell/issues/126#issuecomment-409990674
# https://web.archive.org/web/20210111200639/https://github.com/chriskempson/base16-shell/issues/126
# https://github.com/tinted-theming/tinted-shell/blob/main/USAGE.md#bashzsh
BASE16_SHELL_PATH="$HOME/.config/tinted-theming/tinted-shell"
  [ -s "$BASE16_SHELL_PATH/profile_helper.sh" ] && \
    source "$BASE16_SHELL_PATH/profile_helper.sh"

DEFAULT="default-dark"
DEFAULT_DARK="material"
DEFAULT_LIGHT="solarized-light"

get_xres_col() {
  xrdb -query | grep $1 | cut -f 2
}

set_theme_fn() {
  theme=$1

  # https://github.com/tinted-theming/base16-xresources
  xresources_theme="https://raw.githubusercontent.com/base16-project/base16-xresources/main/xresources/base16-${theme}-256.Xresources"
  mkdir -p ~/.Xresources.d
  curl $xresources_theme > ~/.Xresources.d/colors
  xrdb -load -I$HOME ~/.Xresources

  if [ "$XDG_CURRENT_DESKTOP" = "i3" ]
  then
    color_good="$(get_xres_col color2:)"
    color_bad="$(get_xres_col color1:)"

    sed --in-place --follow-symlinks '/color_good /s/=.*$/= "'"$color_good"'"/' $HOME/.config/i3status/config
    sed --in-place --follow-symlinks '/color_bad /s/=.*$/= "'"$color_bad"'"/'   $HOME/.config/i3status/config

    i3-msg reload
  fi

  set_theme $theme
}

set_wallpaper() {
  bg=$(xrdb -query | grep "*background" | cut -f 2)

  color1="$(get_xres_col color1:)"
  color2="$(get_xres_col color2:)"
  color3="$(get_xres_col color3:)"
  color4="$(get_xres_col color4:)"
  color5="$(get_xres_col color5:)"
  color6="$(get_xres_col color6:)"
  color7="$(get_xres_col color7:)"
  color8="$(get_xres_col color8:)"
  color9="$(get_xres_col color9:)"
  color10="$(get_xres_col color10:)"
  color11="$(get_xres_col color11:)"
  color12="$(get_xres_col color12:)"
  color13="$(get_xres_col color13:)"
  color14="$(get_xres_col color14:)"
  color15="$(get_xres_col color15:)"
  color16="$(get_xres_col color16:)"
  color17="$(get_xres_col color17:)"
  color18="$(get_xres_col color18:)"
  color19="$(get_xres_col color19:)"
  color20="$(get_xres_col color20:)"
  color21="$(get_xres_col color21:)"

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

if [ "$1" = "default" ]; then
  set_theme_fn $DEFAULT
elif [ "$1" = "dark" ]; then
  set_theme_fn $DEFAULT_DARK
elif [ "$1" = "light" ]; then
  set_theme_fn $DEFAULT_LIGHT
else
  set_theme_fn $1
fi

set_wallpaper
