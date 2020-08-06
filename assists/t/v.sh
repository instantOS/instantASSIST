#!/usr/bin/env bash

# assist: set resolution to 1920x1080 in a virtual machine

# this was copied from stackoverflow ;)

# First we need to get the modeline string for xrandr
# Luckily, the tool `gtf` will help you calculate it.
# e.g. `gtf <hRes> <vRes> <refreshRate>`:
VDISPLAY="$(xrandr | grep ' connected' | grep -o '^[^ ]*' | head -1)"

gtf 1920 1080 60

# In this case, the horizontal resolution is 1920px the
# vertical resolution is 1080px & refresh-rate is 60Hz.
# IMPORTANT: BE SURE THE MONITOR SUPPORTS THE RESOLUTION

# Typically, it outputs a line starting with "Modeline"
# e.g. "1920x1080_60.00"  172.80  1920 2040 2248 2576  1080 1081 1084 1118  -HSync +Vsync
# Copy this entire string (except for the starting "Modeline")

# Now, use `xrandr` to add a new display mode. Pass the
# copied string as the parameter to the --newmode option:
xrandr --newmode "1920x1080_60.00" 172.80 1920 2040 2248 2576 1080 1081 1084 1118 -HSync +Vsync

# Well, the string within the quotes is the nick/alias
# of the display mode - you can as well pass something
# as "MyAwesomeHDResolution". But, why though!?!

# Then all you have to do is to add the new mode to the
# display you want to apply, like this:
xrandr --addmode "$VDISPLAY" "1920x1080_60.00"

# VGA1 is the display name, it might differ for you.
# Run `xrandr` without any parameters to be sure.
# The last parameter is the mode-alias/name which
# you've set in the previous command (--newmode)

# It should add the new mode to the display & apply it.
# If it doesn't apply automatically, force it with:
xrandr --output "$VDISPLAY" --mode "1920x1080_60.00"

# That's it... Enjoy the new awesome high-res display!

# NOTE to make the change persistent over reboots:
# - save the script file (with the necessary changes)
# - run it at startup (search the web for "How To")
# Thanks for the feedback!
