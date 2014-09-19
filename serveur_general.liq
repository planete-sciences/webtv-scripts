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

%include "passwords.liq"

# native input format 720x576, output must a multiple of 16 so you must
# divide by 9.
quality=4
set("frame.video.width",720/9*quality)
set("frame.video.height",576/9*quality)


set("server.telnet",true)
set("server.telnet.port",4540)

minimum=mux_audio(audio=blank(),single("resources/BoucleLogo.ogv"))

infini=add([blank(),minimum])
clock.assign_new(sync=false,id="stream_ogv",[
output.icecast(%ogg(%theora,%vorbis),description="La WebTV Planète Sciences",
url="http://webtv.planete-sciences.org",
host="planete-sciences.org",port=5080,password=motdepasse_source,
mount="webtv.ogv",infini)
])

output.icecast(id="gstreamer_webm",%gstreamer(audio="vorbisenc", video="vp8enc", muxer="webmmux"),
description="La WebTV Planète Sciences", url="http://webtv.planete-sciences.org",
host="planete-sciences.org", port=5080, password=motdepasse_source, mount="webtv.webm",
format="video/webm", icy_metadata="false", infini)
