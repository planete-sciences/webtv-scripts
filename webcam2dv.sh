#!/bin/sh

## Quand c'est cassé ou qu'on modifie quelque chose, on le dit sur gitolite
## ou l'on prévient l'auteur pierre.boutillier@PLASCI afin d'en laisser la trace

# Copyright 2013 Planète Sciences
# This file is part of webtv-plasci

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

assure_commande avconv libav-tools
assure_commande dvsource-file dvsource

[ $# -eq 2 ] || { echo "Usage: $0 nom_serveur_dvswitch port_serveur_dvswitch" ; echo "Capture le flux depuis un boitier usb et l'envoi au serveur_dvswitch." ; exit 2 ; }

[ "$TERM" = "screen" ] || { echo "Il faut lancer ce script en utilisant screen pour que la diffusion survive aux deconnections." ; exit 4 ; }

avconv -f video4linux2 -pix_fmt uyvy422 -s 720x576 -i /dev/video0 -r 25 -c:a anullsrc -target pal-dv - | \
    dvsource-file /dev/stdin -h "$1" -p "$2"
