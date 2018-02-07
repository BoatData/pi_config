
# setup signalk
base=/home/boatdata
mkdir -p ${base}/tmp
cd ${base}/tmp

if [ -d "boatdata-signalk" ]; then
  (cd signalk-server-node && git pull)
else
  git clone git@github.com:BoatData/signalk-server-node
fi

sudo apt-get install -y libnss-mdns avahi-utils libavahi-compat-libdnssd-dev

(cd signalk-server-node && npm install && npm install mnds && sudo bash ./rpi-setup.sh)

sudo systemctl start signalk.service
sudo systemctl start signalk.socket

cd ${base}/tmp
sudo apt-get install -y xsltproc
git clone git://github.com/canboat/canboat
cd canboat
make

sudo cpan install Config::General

# change the following options to suit your requirements
cat >${base}/pi_config/config/n2kd.conf<<n2kd_monitor
ACTISENSE_PRIMARY=/dev/actisense-can
MONITOR=true
N2KD_OPTIONS=--src-filter !3
ANALYZER_OPTIONS=-clocksrc 36
n2kd_monitor

sudo ln -s ${base}/pi_config/config/n2kd.conf /etc/default/n2kd

/usr/local/bin/n2kd_monitor
