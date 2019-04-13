

base=/home/boatdata

source ${base}/pi_config/charts/config.sh ${1}

echo "Configure renderd"
cat > /etc/default/renderd <<EOF
# Override some default value
RUNASUSER=${OSM_USER}
#DAEMON_ARGS=""
EOF

mkdir -p /var/run/renderd
chmod og+w /var/run/renderd
mkdir -p /var/lib/mod_tile
chmod og+w /var/lib/mod_tile

cat > /etc/renderd.conf <<EOF
[renderd]
stats_file=/var/run/renderd/renderd.stats
socketname=/var/run/renderd/renderd.sock
num_threads=${NP}
tile_dir=/var/lib/mod_tile

[mapnik]
plugins_dir=$(mapnik-config --input-plugins)
font_dir=/usr/share/fonts/truetype
font_dir_recurse=true
;TILEDIR=/home/${OSM_USER}/www/mod_tile

[default]
plugins_dir=$(mapnik-config --input-plugins)
font_dir=/usr/share/fonts/truetype
font_dir_recurse=true
;TILEDIR=/home/${OSM_USER}/www/mod_tile
URI=/osm/
XML=/usr/share/openstreetmap-carto/style.xml
DESCRIPTION=This is the standard osm mapnik style
;ATTRIBUTION=&copy;<a href=\"http://www.openstreetmap.org/\">OpenStreetMap</a> and <a href=\"http://wiki.openstreetmap.org/wiki/Contributors\">contributors</a>, <a href=\"http://creativecommons.org/licenses/by-sa/2.0/\">CC-BY-SA</a>
;HOST=tile.openstreetmap.org
;SERVER_ALIAS=http://a.tile.openstreetmap.org
;SERVER_ALIAS=http://b.tile.openstreetmap.org
;HTCPHOST=proxy.openstreetmap.org
EOF

service renderd restart
