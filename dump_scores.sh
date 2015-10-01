#!/bin/sh

# Configuration
url_poolzor='http://dev.elektordi.net/plasci/poules/'
nb_matchs=363

# Prérequis
# - xrandr -s 1024x768
# - chromium --kiosk ${url_poolzor}test_diffscores.php

sleep 5 && for i in $(seq --format='%03.0f' 1 ${nb_matchs})
	   do
	       gst-launch-1.0 ximagesrc num-buffers=220 show-pointer=false ! video/x-raw,framerate=30/1 ! videoconvert ! queue ! x264enc ! queue ! mp4mux ! filesink location="coupe15-score-match$1.mp4" &

	       wget "${url_poolzor}ajax.php?page=diff_mode&action=set&newmode=match%3A$i" -O - -q
	       sleep 22
	       wget "${url_poolzor}ajax.php?page=diff_mode&action=set&newmode=match%3A0" -O - -q
	       sleep 3

	   done
