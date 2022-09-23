#!/usr/bin/env bash

dir="$HOME/.config/polybar"
themes=(`ls --hide="launch.sh" $dir`)

launch_bar() {
	# Terminate already running bar instances
	killall -q polybar

	# Wait until the processes have been shut down
	while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

	# Launch the bar
    polybar -q main -c "$dir/$style/config.ini" &	
}

if [[ "$1" == "--xmonad" ]]; then
	style="xmonad"
	launch_bar

elif [[ "$1" == "--i3" ]]; then
	style="i3"
	launch_bar

else
	cat <<- EOF
	Usage : launch.sh --theme
		
	Available Themes :
	--xmonad    --i3
	EOF
fi
