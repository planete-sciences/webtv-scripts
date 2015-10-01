#!/bin/sh

## Quand c'est cassé ou que l'on modifie quelque chose, on le dit sur github
## ou l'on prévient l'auteur pierre.boutillier@PLASCI afin d'en laisser la trace

# Copyright 2015 Planète Sciences
# This file is part of webtv-scripts

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

assure_commande () { ## assure_commande commande paquet
which $1 > /dev/null ||\
 { echo "Commande \"$1\" introuvable, il faut surement installer le paquet $2."
 exit 3 ; }
}

assure_commande gst-launch-1.0 "gstreamer1.0-tools & gstreamer1.0-plugins-good"

[ $# -eq 4 ] || { echo "Usage: $0 nom_serveur_icecast port_serveur_icecast mot_de_passe_icecast point_de_montage" ; echo "Capture le flux depuis un boitier usb et l'envoi au serveur icecast directement tout en écrivant l'ogv sur le disque." ; exit 2 ; }

[ "$TERM" = "screen" ] || { echo "Il faut lancer ce script en utilisant screen pour que la diffusion survive aux deconnections." ; exit 4 ; }

gst-launch-1.0  v4l2src device=/dev/video0 norm=PAL ! videoconvert ! videoscale ! queue ! theoraenc ! oggmux name=toto ! tee  name=dump ! queue ! shout2send ip=$1 mount=lelive.ogv password=$3 port=$2 pulsesrc ! queue ! audioconvert ! "audio/x-raw, channels=2" ! vorbisenc ! toto. dump. ! queue ! filesink location=lelive-$(date +%Y-%m-%d_%H-%M-%S).ogv
