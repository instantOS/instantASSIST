#!/usr/bin/env bash
GPUS=$(ls /sys/class/backlight | wc -l)

if [ "$GPUS" = "0" ]; then
    echo "no device with adjustable brightness found"
    exit
fi

sudo groupadd video
VIDEOUSER=$(whoami)
sudo usermod -a -G video "$VIDEOUSER"
if [ "$GPUS" = "1" ]; then
    if [ -e /etc/udev/rules.d/backlight.rules ]; then
        echo "backlight rules already existing"
        exit
    fi
    BGPU=$(ls /sys/class/backlight)
    echo 'ACTION=="add", SUBSYSTEM=="backlight", KERNEL=="'"$BGPU"'", RUN+="/bin/chgrp video /sys/class/backlight/%k/brightness"' |
        sudo tee -a /etc/udev/rules.d/backlight.rules
    echo 'ACTION=="add", SUBSYSTEM=="backlight", KERNEL=="'"$BGPU"'", RUN+="/bin/chmod g+w /sys/class/backlight/%k/brightness"' |
        sudo tee -a /etc/udev/rules.d/backlight.rules
fi
