#!/bin/bash
 
entries="Area Screen Output Active Window CopyArea "
 
selected=$(printf '%s\n' $entries | wofi --style=$HOME/.config/wofi/style.widgets.css --conf=$HOME/.config/wofi/config.screenshot | awk '{print tolower($1)}')
 
case $selected in
  copyarea)
    /usr/share/sway/scripts/grimshot --notify copy area;;
  area)
    /usr/share/sway/scripts/grimshot --notify save area;;
  screen)
    /usr/share/sway/scripts/grimshot --notify save screen;;
  output)
    /usr/share/sway/scripts/grimshot --notify save output;;
  active)
    /usr/share/sway/scripts/grimshot --notify save active;;
  window)
    /usr/share/sway/scripts/grimshot --notify save window;;
esac
