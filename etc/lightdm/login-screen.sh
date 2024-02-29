#!/bin/sh

# the script will not work if xrandr is not available
if [ -z "$(which xrandr)" ]; then
    exit 1
fi

SECONDARY_SUBSTRING="eDP"

PRIMARY_OUT=""
SECONDARY_OUT=""
LAPTOP_OUTPUT="DP-1-1"

old_IFS="${IFS}"
IFS=$'\n'
for out in `xrandr | grep connected | cut -d ' ' -f 1-2`; do
    name=`echo $out | cut -d ' ' -f 1`
    state=`echo $out | cut -d ' ' -f 2`
    if [ "$state" = "connected" ]; then
        case "$name" in
            # disable a monitor connected via LVDS
            ${SECONDARY_SUBSTRING}*)
                if [ -z "$SECONDARY_OUT" ]; then
                    SECONDARY_OUT="$name"
                fi
                ;;
            *)
                # set the 'first' external monitor as the
                # primary one, disable the other external monitors
                if [ -z "$PRIMARY_OUT" ]; then
                    PRIMARY_OUT="$name"
                fi
                ;;
        esac
    fi
done
IFS="${old_IFS}"

# If there is an internal screen, as well as at least one external monitor, then
# disable the internal monitor and use the external monitor as the primary one.
# 
# Otherwise, if there are any external monitors, use the 'first' detected one
# as the primary monitor.
if [ -n "$SECONDARY_OUT" ] && [ -n "$PRIMARY_OUT" ]; then
    xrandr --output "$PRIMARY_OUT" --primary --auto --pos 0x0  --rotate normal\
           --output "$SECONDARY_OUT" --auto --pos 2560x0 --rotate normal\
           --output "$LAPTOP_OUTPUT" --off
elif [ -n "$SECONDARY_OUT" ] && [ -z "$PRIMARY_OUT" ]; then
    xrandr --output "$SECONDARY_OUT" --primary --auto --pos 0x0 --rotate normal\
           --output "$LAPTOP_OUTPUT"
fi
exit 0
