

# Change these values if needed
OSM_USER="boatdata" #linux and db user
OSM_DB="gis" #database name
VHOST=$(hostname -f)


# Internal variables
PBF_URL=${1}
PBF_FILE="/home/${OSM_USER}/osm/${PBF_URL##*/}"
UPDATE_URL="$(echo ${PBF_URL} | sed 's/latest.osm.pbf/updates/')"
if [[ ${PBF_URL} =~ "planet" ]]; then
    # For planet file, hard code the update url
    UPDATE_URL = "http://planet.openstreetmap.org/replication/day"
fi
