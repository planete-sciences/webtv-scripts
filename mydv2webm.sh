#!/bin/sh

[ $# -eq 1 ] || { echo "et l'argument ?" && exit 1 ; }

gst-launch-1.0 webmmux name=sortie ! filesink location="${1%.dv}.webm" filesrc location="$1" ! dvdemux name=entree entree. ! queue! audioconvert ! vorbisenc ! queue ! sortie. entree.video ! queue ! dvdec ! videoconvert ! vp8enc ! progressreport ! queue ! sortie.
