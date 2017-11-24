base=/home/boatdata/pi_config

if [ "${SSID}" == "" ] ; then
  echo SSID environment variable required
  exit
fi

if [ "${PASSWORD}" == "" ] ; then
  echo PASSWORD environment variable required
  exit
fi

wpa_passphrase ${SSID} ${PASSWORD} | sudo cat - > /etc/wpa_supplicant/wpa_supplicant.conf
