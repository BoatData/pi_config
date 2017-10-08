
sudo apt-get install -y libusb-1.0-0-dev

base=/home/boatdata
mkdir -p ${base}/tmp
cd ${base}/tmp

if [ ! -d "rtl-sdr" ]; then
  git clone git://git.osmocom.org/rtl-sdr.git
fi
cd rtl-sdr/
mkdir build
cd build
cmake ../ -DINSTALL_UDEV_RULES=ON
make
sudo make install
sudo ldconfig
sudo cp ../rtl-sdr.rules /etc/udev/rules.d/

cd ${base}/tmp
# now build the ais program
git clone https://github.com/dgiardini/rtl-ais
cd rtl-ais
make
sudo cp rtl-ais /usr/local/bin


cd ${base}/pi_config
sudo cp sources/blacklist-rtl.conf /etc/modprobe.d/


echo "reboot required for ais dongle"
