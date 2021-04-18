#!/usr/bin/dash

# assist: invert screen colors

instantinstall xcalib && \

{
if [ -e /tmp/.xinvert ]; then
    xcalib -c
    rm /tmp/.xinvert
else
    xcalib -i -a
    touch /tmp/.xinvert
fi
}
