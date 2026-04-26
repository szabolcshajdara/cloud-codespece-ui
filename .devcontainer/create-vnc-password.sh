#!/usr/bin/env bash

# set password
mkdir -p /home/vscode/.vnc
echo ${VNC_PASSWORD:-WNdM0BFgbx72Vp7Rfpj9} | vncpasswd -f > /home/vscode/.vnc/passwd
chmod 600 /home/vscode/.vnc/passwd
