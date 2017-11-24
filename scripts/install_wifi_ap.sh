# configure the pi wifi access point

base=/home/boatdata/pi_config

sudo apt-get install dnsmasq hostapd

sudo systemctl stop dnsmasq
sudo systemctl stop hostapd

# configure the network IP
cat >${base}/config/wlan0.conf<<heredoc
allow-hotplug wlan0
iface wlan0 inet static
    address 192.168.1.1
    netmask 255.255.255.0
    network 192.168.1.0
heredoc

sudo ln -s ${base}/config/wlan0.conf /etc/network/interfaces.d/wlan0.conf

sudo service dhcpcd restart
sudo ifdown wlan0
sudo ifup wlan0

cat >${base}/config/dnsmasq.conf<<heredoc
interface=wlan0    # wireless interface is usually wlan0
  dhcp-range=192.168.1.2,192.168.1.20,255.255.255.0,24h
heredoc

sudo ln -s ${base}/config/dnsmasq.conf /etc/dnsmasq.conf

# create the hostapd config file
SSID=SmartBoat PASSWORD=SmartBoatNetwork bash ${base}/create_ap.sh

sudo rm /etc/default/hostapd
cp ${base}/sources/hostapd.default ${base}/config/hostapd.default
sudo ln -s ${base}/config/hostapd.default /etc/default/hostapd

sudo service hostapd start
sudo service dnsmasq start
