

sudo apt-get -y libfreeimage-dev

base=/home/boatdata
mkdir -p ${base}/tmp
mkdir ${base}/bin

cp pi_config/sources/imgkap.c ${base}/tmp/

cd ${base}/tmp

gcc -I./FreeImage/Source/ imgkap.c -O3 -s -lm -lfreeimage -o ${base}/bin/imgkap
