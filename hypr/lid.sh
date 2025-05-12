#!/bin/sh

set -e

open() {
    hyprctl keyword monitor "eDP-1, preferred, auto, 1"
}

close() {
    num_monitors=$(hyprctl monitors -j | jq '. | length')

    if [ "$num_monitors" != "1" ];
    then
        hyprctl keyword monitor "eDP-1, disable"
    fi
}

cmd="$1"

if [ "$cmd" == "open" ];
then
    open
elif [ "$cmd" == "close" ];
then
    close
fi
