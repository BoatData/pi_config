
base=/home/boatdata

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 {pbf_url}"; exit 1;
fi

source ${base}/pi_config/charts/config.sh ${1}

#-------------------------------------------------------------------------------
#--- 3. Prepare database
#-------------------------------------------------------------------------------
echo ""
echo "3. Prepare database"
echo "==================="
# Create the database schema (as postgres user)
su ${OSM_USER} <<EOF
psql -c "DROP TABLE IF EXISTS planet_osm_line CASCADE;" -d ${OSM_DB}
psql -c "DROP TABLE IF EXISTS planet_osm_nodes CASCADE;" -d ${OSM_DB}
psql -c "DROP TABLE IF EXISTS planet_osm_point CASCADE;" -d ${OSM_DB}
psql -c "DROP TABLE IF EXISTS planet_osm_polygon CASCADE;" -d ${OSM_DB}
psql -c "DROP TABLE IF EXISTS planet_osm_rels CASCADE;" -d ${OSM_DB}
psql -c "DROP TABLE IF EXISTS planet_osm_roads CASCADE;" -d ${OSM_DB}
psql -c "DROP TABLE IF EXISTS planet_osm_ways CASCADE;" -d ${OSM_DB}
EOF

# psql -c "DROP TABLE IF EXISTS spatial_ref_sys CASCADE;" -d ${OSM_DB}

su postgres <<EOF

psql -c "DROP EXTENSION IF EXISTS hstore;" -d ${OSM_DB}
psql -c "DROP EXTENSION IF EXISTS postgis;" -d ${OSM_DB}

psql -c "CREATE EXTENSION hstore;" -d ${OSM_DB}
psql -c "CREATE EXTENSION postgis;" -d ${OSM_DB}
EOF
