base=/home/boatdata

source ${base}/pi_config/charts/config.sh ${1}


cat <<EOF

The values for the installation are
User          : ${OSM_USER}
Database name : ${OSM_DB}
Server name   : ${VHOST}
Backend       : mod_tile
PBF URL       : ${PBF_URL}
PBF file      : ${PBF_FILE}
Update        : ${UPDATE_URL}

To change these values, edit the script file

If the values are not correct, break this script (CTRL-C) now or wait 10s to continue

Some package will ask you some question, answer with the default values which
have been modified to represent your values.

You can find your an example at
http://${VHOST}/osm

The rendered/downloaded tiles are stored in
/var/lib/mod_tile

The main renderd config is
/etc/renderd.cfg
/etc/default/renderd

EOF
