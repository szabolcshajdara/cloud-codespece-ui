#!/bin/bash

export DISPLAY=:1

# set password if not already created
mkdir -p /home/vscode/.vnc
if [ ! -f /home/vscode/.vnc/passwd ]; then
    echo ${VNC_PASSWORD:-codespace} | x11vnc -storepasswd - /home/vscode/.vnc/passwd
fi

# start virtual display
Xvfb :1 -screen 0 1280x800x24 &

sleep 2

# start desktop
startxfce4 &

# start VNC server
x11vnc -display :1 \
  -rfbauth /home/vscode/.vnc/passwd \
  -forever \
  -shared \
  -rfbport 5900 &

# start web VNC
#websockify --web=/usr/share/novnc 6080 localhost:5900
