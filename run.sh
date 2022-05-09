#!/bin/bash

#I have not verified that the mac half of this script
#works properly as I do not have a mac on hand anymore
#to test with

if [ $OSTYPE == 'linux-gnu' ]; then
	docker run --privileged -it --rm --net=host --env DISPLAY=unix$DISPLAY --volume="$HOME/.Xauthority:/root/.Xauthority:rw" --volume /tmp/.X11-unix:/tmp/.X11-unix doom
else
	IP=$(ifconfig en0 | grep inet | awk '$1=="inet" {print $2}')
	docker run --privileged -it -e DISPLAY=$IP:0 -v /tmp/.X11-unix:/tmp/.X11-unix doom
fi
