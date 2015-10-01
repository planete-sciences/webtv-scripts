ls /mnt/data2/coupe15-seriefinale-mix* | sed -e 's/^\(.*\)-\([0-9].dv\)$/mv & \1-0\2/g' | sh

mv /mnt/data2/coupe15-seriefinale-mix.dv /mnt/data2/coupe15-seriefinale-mix-00.dv

cat coupe15-seriefinale-mix-*.dv > coupe15-seriefinale-mix.dv

~/mydv2webm.sh coupe15-seriefinale-mix.dv
