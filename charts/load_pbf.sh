
base=/home/boatdata
mkdir -p ${base}/tmp
mkdir -p ${base}/osm

#-------------------------------------------------------------------------------
#--- 0. Introduction
#-------------------------------------------------------------------------------
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 {pbf_url}"; exit 1;
fi

# Make sure only root can run our script
if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root";  exit 1;
fi

# bash ${base}/pi_config/charts/install_deps.sh ${1}

bash ${base}/pi_config/charts/setup_db.sh ${1}

# bash ${base}/pi_config/charts/prep_apache.sh ${1}

bash ${base}/pi_config/charts/download_pbf.sh ${1}

bash ${base}/pi_config/charts/drop_tables.sh ${1}

bash ${base}/pi_config/charts/insert_pbf.sh ${1}

bash ${base}/pi_config/charts/setup_cron.sh ${1}

bash ${base}/pi_config/charts/cfg_renderd.sh ${1}


echo ""
echo "5. Installing demo pages"
echo "========================"
cat <<EOF

You can find your an example at
http://${VHOST}/osm

The rendered/downloaded tiles are stored in
/var/lib/mod_tile

The main renderd config is
/etc/renderd.cfg
/etc/default/renderd
EOF

service apache2 restart
echo "--- Finished installation"
