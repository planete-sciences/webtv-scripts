#!/usr/bin/liquidsoap

# Copyright 2014 Planète Sciences
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

# config
ajuste_son = 0.5
in="~/Movies/rentre_robot_2014/rentree-4.dv"
out="~/Movies/rentre_robot_2014/rentree_robot_2014-trophee.webm"
# fin config

set("frame.video.width",720)
set("frame.video.height",576)

afaire=once(single(id="fichier",in))

avec_logo=switch(track_sensitive=false,[((fun () -> source.is_ready(afaire)),
video.add_image(width=120,height=84,file="resources/LogoIncrustation.png",afaire))])

transforme=amplify(ajuste_son,avec_logo)

clock.assign_new(id="ecriture",sync=false,
[output.file(%gstreamer(audio="vorbisenc", video="vp8enc", muxer="webmmux"),
fallible=true,on_stop=shutdown,out,transforme)])
