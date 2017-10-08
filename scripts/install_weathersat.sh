

sudo apt-get install -y sox at predict

base=/home/boatdata
mkdir -p ${base}/tmp
cd ${base}/tmp

wget http://www.wxtoimg.com/beta/wxtoimg-armhf-2.11.2-beta.deb
sudo dpkg -i wxtoimg-armhf-2.11.2-beta.deb
echo YES | wxtoimg

cat >> ~/.wxtoimgrc <<wxtoimgrcconf
Latitude: 13.8320
Longitude: 100.5600
Altitude: 25
wxtoimgrcconf

cd ${base}
mkdir -p ~/weather/predict
cp pi_config/sources/weathersat_*.sh !$
