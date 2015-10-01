set("frame.video.width",480)
set("frame.video.height",384)

set("server.telnet",true)
set("server.telnet.port",4540)

safe=rotate([single("SpotWebTV.ogv"),mux_audio(audio=blank(),single("BoucleLogo.ogv"))])
fichiers=fallback([request.equeue(id="ajouer"),safe])

#live=input.http("http://192.168.0.2:8000/lelive.ogv")
rawlive=input.harbor("lelive.ogv",port=4545,password="cquetuveuxmongars")
live=
mux_audio(audio=blank(),
add([
video.add_text.gstreamer("Le live !",
font="/usr/share/fonts/truetype/ttf-liberation/LiberationMono-Regular.ttf",
rawlive
)
,switch(track_sensitive=false,[((fun () -> source.is_ready(rawlive)),
single(
#width=30,height=30,x=10,y=10,
"LogoIncrustation.png"))
])
])
)

radio=fallback(track_sensitive=false,[live,fichiers])

infinite= add([blank(),radio])
output.icecast(%ogg(%theora,%vorbis),host="192.168.0.2",mount="webtv.ogv",password="C1secret",infinite)