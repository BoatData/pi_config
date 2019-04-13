
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
su postgres <<EOF
cd ~
createuser ${OSM_USER}
createdb -E UTF8 -O ${OSM_USER} ${OSM_DB}
psql -c "CREATE EXTENSION hstore;" -d ${OSM_DB}
psql -c "CREATE EXTENSION postgis;" -d ${OSM_DB}
EOF
