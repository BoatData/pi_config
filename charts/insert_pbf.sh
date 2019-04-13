

base=/home/boatdata

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 {pbf_url}"; exit 1;
fi

source ${base}/pi_config/charts/config.sh ${1}

NP=$(grep -c 'model name' /proc/cpuinfo)

#-------------------------------------------------------------------------------
#--- 4. Download file and inject in database
#-------------------------------------------------------------------------------
echo ""
echo "4. Populate database"
echo "======================"
let C_MEM=800  # default $(free -m | grep -i 'mem:' | sed 's/[ \t]\+/ /g' | cut -f4,7 -d' ' | tr ' ' '+')-200
su ${OSM_USER} <<EOF
cd /home/${OSM_USER}/osm
# Prepare osmosis working dir and config file
#osmosis --read-replication-interval-init workingDirectory=.
sed -i.save "s|#\?baseUrl=.*|baseUrl=${UPDATE_URL}|" configuration.txt
# Inject in database (could be very long for the planet)
osm2pgsql --slim -d ${OSM_DB} -C ${C_MEM} --number-processes ${NP} --hstore -S /usr/share/osm2pgsql/default.style ${PBF_FILE}
#rm ${PBF_FILE}
EOF
