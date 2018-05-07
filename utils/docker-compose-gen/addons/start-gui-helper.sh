#!/bin/sh

[ -z "$1" ] && echo "Usage: start-gui-helper.sh x-programm" && exit 1

CMD="$1"
shift

[ -z "$DISPLAY" ] && DISPLAY=:0

# first we need our security cookie and add it to user's .Xauthority
mcookie | sed -e 's/^/add :0 MIT-MAGIC-COOKIE-1 /' | xauth -q

# now place the security cookie with FamilyWild on volume so client can use it
# see http://stackoverflow.com/25280523 for details on the following command
xauth nlist $DISPLAY | sed -e 's/^..../ffff/' | xauth -f /Xauthority/xserver.xauth nmerge -

[ -z "$VNC_PASSWORD" ] && VNC_PASSWORD="123"
[ -z "$XFB_SCREEN" ] && XFB_SCREEN=1024x768x24
[ -n "$XFB_SCREEN_DPI" ] && DPI_OPTIONS="-dpi $XFB_SCREEN_DPI"
[ -z "$VNC_NO_SHARED" ] && VNC_SHARED='' || VNC_SHARED="-shared"
[ -n "$VNC_PORT" ] || VNC_PORT=5900

VNC_AUTH="-passwd $VNC_PASSWORD"
if [ -n "$VNC_PASSWORD_FROM_FILE" ]; then
    VNC_AUTH="-usepw -rfbauth $VNC_PASSWORD_FROM_FILE"
fi

export DISPLAY

# now boot X-Server, tell it to our cookie and give it sometime to start up
Xvfb $DISPLAY -auth ~/.Xauthority $DPI_OPTIONS -screen 0 $XFB_SCREEN >>~/xvfb.log 2>&1 &
sleep 2

# xsetroot -solid "#666699"
# xsetroot -cursor_name left_ptr

[ -z "$NO_RUN_VNC" ] && x11vnc -forever $VNC_AUTH -bg $VNC_SHARED -rfbport $VNC_PORT -display $DISPLAY

$CMD $*
