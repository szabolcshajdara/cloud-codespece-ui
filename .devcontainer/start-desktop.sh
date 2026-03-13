#!/usr/bin/env bash

export DISPLAY=:1

mkdir -p /tmp/.X11-unix
chmod 1777 /tmp/.X11-unix

mkdir -p /home/vscode/.vnc

# set password
if [ ! -f /home/vscode/.vnc/passwd ]; then
    echo ${VNC_PASSWORD:-codespace} | x11vnc -storepasswd - /home/vscode/.vnc/passwd
fi

# start virtual display if not running
if ! pgrep Xvfb >/dev/null; then
    Xvfb :1 -screen 0 1280x800x24 &
    sleep 2
fi

# start dbus session if needed
if [ -z "$DBUS_SESSION_BUS_ADDRESS" ]; then
    eval $(dbus-launch --sh-syntax)
fi

# start xfce if not already running
if ! pgrep xfce4-session >/dev/null; then
    startxfce4 &
fi

# start VNC
if ! pgrep x11vnc >/dev/null; then
    x11vnc \
      -display :1 \
      -rfbauth /home/vscode/.vnc/passwd \
      -forever \
      -shared \
      -rfbport 5900 \
      -noxdamage &
fi

# start noVNC
if ! pgrep websockify >/dev/null; then
    websockify --web=/usr/share/novnc 6080 localhost:5900
fi
