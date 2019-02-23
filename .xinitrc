#!/bin/sh

systemctl --user import-environment DISPLAY XAUTHORITY

if which dbus-update-activation-environment >/dev/null 2>&1; then
        dbus-update-activation-environment DISPLAY XAUTHORITY
fi
#exec dbus-launch --exit-with-session gnome-session

/home/lindell/.screenlayout/arch.sh

feh --bg-scale /home/lindell/Downloads/wallpaper.jpg
xrdb ~/.Xresources

[[ -f ~/.Xmodmap ]] && xmodmap ~/.Xmodmap

i3
