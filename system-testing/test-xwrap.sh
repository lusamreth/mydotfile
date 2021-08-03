#!/bin/bash

p="$HOME/Downloads/hibike-running.gif"
p0="$HOME/Downloads/girl-sat-down-raining.gif"
p1="$HOME/Downloads/cute.mp4"
p2="$HOME/Downloads/vicecity.gif"
#adv="$HOME/Downloads/water.gif"
adv="$HOME/Downloads/pixeltree.mp4"

fetch_media(){
    base="$HOME/Downloads"
    pathlist=("Bruh")
    while IFS=  read -r -d '$'\0''; do
        pathlist+=("$REPLY")
    done < <(find ~/Downloads -name '*.jpg' -o -name '*.jpeg' \
        -o -name '*.gif' -o -name '*.mp4' -print0)

    echo ${pathlist[0]}

}

fetch_media

run_mpv_bg() {
    #arguments
    path=$1 

    nice xwinwrap -b -s -fs -st -sp -nf -ni -ov -fdt -- \
    mpv -wid WID --loop=inf --really-quiet --framedrop=vo --no-audio \
    --panscan="1.0" $path
}


if pgrep -x "mpv" || pgrep -x "xwinwrap"
    echo "Killing the mpv process!"
    killall mpv
    then nitrogen --restore &
else 
    run_mpv_bg $adv
fi

echo "switch from wallpaper to vid!"


