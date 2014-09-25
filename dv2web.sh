#!/bin/sh

dvsink-command -h $1 -p $2 -- gst-launch-1.0 \
oggmux name=ogv ! queue ! shout2send ip="$3" password="$4" port=4545 mount=lelive.ogv \
fdsrc ! dvdemux name=raw ! \
dvdec ! queue ! videoconvert ! videorate ! videoscale ! \
"video/x-raw,width=416,height=320" ! queue ! theoraenc ! queue ! ogv. \
raw. ! queue ! audioconvert ! vorbisenc ! queue ! ogv.
