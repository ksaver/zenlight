#!/usr/bin/env bash
# zenlight.sh
# set back light using zenity scale

# function to check if a command exists in path
exists(){
    type "$1" >/dev/null 2>&1
}

# check dependencies..
dependencies=("xbacklight" "zenity")

for dep in ${dependencies[*]}; do
    if (! exists $dep); then
        echo >&2 "Command '$dep' required, but it's not installed.."
        echo >&2 "Install it in order to proceed."
        exit 1
    fi
done

# get the current backlight value (float number)
CURRENTXBL=$(xbacklight -get)

# remove the decimal part in current float value
ROUNDXBL=$(echo $CURRENTXBL |xargs printf "%.f")

# zenity dialog
# redirects std err to /dev/null to avoid a warning..
NEWXBL=$(zenity --title "ZenBackLight v0.1" \
        --scale --value=$ROUNDXBL \
        --text="set xbacklight:" 2>/dev/null)

# and.. set new backlight value.
xbacklight -set $NEWXBL

