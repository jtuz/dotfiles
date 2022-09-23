#!/bin/bash

function run {
    if ! pgrep $1 ;
    then 
        $@&
    fi
}

$HOME/.screenlayout/rotate-screens.sh
(run $HOME/.config/polybar/launch.sh --xmonad)
(run $HOME/bin/redshift.sh) &
(run $HOME/bin/checkupdates.sh) &
run /usr/bin/blueman-applet &
run /usr/bin/nm-applet --sm-disable --indicator &
run /usr/bin/parcellite &
run /usr/bin/xscreensaver -no-splash &
/usr/bin/nitrogen --restore &
