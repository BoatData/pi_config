# run the node-red install script

# node red installed in raspbian April 2019
#bash <(curl -sL https://raw.githubusercontent.com/node-red/raspbian-deb-package/master/resources/update-nodejs-and-nodered)

# copy node-red service which runs as root for GPIO access
#base=/home/boatdata
#cd ${base}
#sudo cp pi_config/sources/nodered.service /lib/systemd/system/

cd ~/.node-red && npm install --save node-red-dashboard node-red-node-serialport

# sudo systemctl enable nodered.service

# connect to the node-red editor on http://localhost:1880
