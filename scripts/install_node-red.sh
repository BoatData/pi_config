# run the node-red install script

bash <(curl -sL https://raw.githubusercontent.com/node-red/raspbian-deb-package/master/resources/update-nodejs-and-nodered)

cd ~/.node-red

npm install --save johnny-five node-red-contrib-gpio raspi-io node-red-dashboard node-red-contrib-modbus

sudo systemctl enable nodered.service

# connect to the node-red editor on http://localhost:1880
