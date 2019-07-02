#!/bin/sh

x-terminal-emulator -e "/bin/sh -c \"while true; do play "$1/extras/george.wav" trim 10 7.45 &> /dev/null;sleep 7.4;done\"; /bin/bash"