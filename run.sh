#!/bin/bash

# This script may need to be called via 'dot space dot'
# syntax in order to function properly depending on the
# specifics of your system's configuration. For instance,
# X11 doesn't like to play nice with environment variables
# in some contexts

# I have not verified that the mac half of this script
# works properly as I do not have a mac on hand anymore
# to test with

if [ $OSTYPE == 'linux-gnu' ]; then
	docker run --privileged -it --rm --net=host --env DISPLAY=unix$DISPLAY --volume="$HOME/.Xauthority:/root/.Xauthority:rw" --volume /tmp/.X11-unix:/tmp/.X11-unix doom
else # This statement is Mac specific
	IP=$(ifconfig en0 | grep inet | awk '$1=="inet" {print $2}')
	docker run --privileged -it -e DISPLAY=$IP:0 -v /tmp/.X11-unix:/tmp/.X11-unix doom
fi
