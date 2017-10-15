
# copy the udev usb rules
base=/home/boatdata
cd ${base}
sudo cp pi_config/sources/99-usb-serial.rules /etc/udev/rules.d/
