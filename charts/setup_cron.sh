
base=/home/boatdata

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 {pbf_url}"; exit 1;
fi

source ${base}/pi_config/charts/config.sh ${1}


# Prepare the daily cron job for data update
cat > /etc/cron.daily/osm-update <<EOF
#!/bin/bash
# Switch to osm user
su ${OSM_USER} <<CRONEOF
cd /home/${OSM_USER}/OpenStreetMap
while [ \\\$(cat /home/${OSM_USER}/OpenStreetMap/state.txt | grep '^sequenceNumber=') != \\\$(curl -sL ${UPDATE_URL}/state.txt | grep '^sequenceNumber=') ]
do
    echo "--- Updating data (Local: \$(cat /home/${OSM_USER}/OpenStreetMap/state.txt | grep '^sequenceNumber='), Online: \$(curl -sL ${UPDATE_URL}/state.txt | grep '^sequenceNumber='))"
    osmosis --read-replication-interval --simplify-change --write-xml-change changes.osc.gz
    # Get available memory just before we call osm2pgsql!
    let C_MEM=\\\$(free -m | grep -i 'mem:' | sed 's/[ \t]\+/ /g' | cut -f4,7 -d' ' | tr ' ' '+')-200
    osm2pgsql --append --slim -d ${OSM_DB} -C \\\${C_MEM} --number-processes ${NP} -e15 -o expire.list --hstore changes.osc.gz
    sleep 2s
    # If the mod_tile is used, the render_expired command exist and use it to
    # mark dirty tile (will be re-render again)
    cat expire.list | render_expired --min-zoom=15 --touch-from=15 >/dev/null
    sleep 60s
done
echo "--- Data is up to date."
CRONEOF
EOF
chmod +x /etc/cron.daily/osm-update
