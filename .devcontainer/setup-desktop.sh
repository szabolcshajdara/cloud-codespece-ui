#!/usr/bin/env bash
set -e

sudo apt-get update
sudo apt-get install -y \
  xfce4 xfce4-goodies \
  tigervnc-standalone-server \
  novnc websockify

# Set up VNC
mkdir -p ~/.vnc
cat <<EOF > ~/.vnc/xstartup
#!/bin/sh
unset SESSION_MANAGER
unset DBUS_SESSION_BUS_ADDRESS
exec startxfce4 &
EOF
chmod +x ~/.vnc/xstartup

# Start VNC + noVNC
vncserver -localhost no :1
websockify --web=/usr/share/novnc/ 6080 localhost:5901 &

