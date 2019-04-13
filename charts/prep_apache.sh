base=/home/boatdata

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 {pbf_url}"; exit 1;
fi

source ${base}/pi_config/charts/config.sh ${1}

cd ${base}/tmp

#-------------------------------------------------------------------------------
#--- 5. Configure backend
#-------------------------------------------------------------------------------
echo ""
echo "5. Preparing backend"
echo "===================="
#---Configure mod_tile and renderd
echo "Configure mod_tile,renderd and apache"

# Clone and compile mod_tile
if [ ! -d mod_tile ]; then
  git clone https://github.com/openstreetmap/mod_tile.git
fi

cd mod_tile
dpkg-buildpackage -i -b -uc -us
cd ..
# Install build packages
dpkg -i renderd_*.deb
dpkg -i libapache2-mod-tile_*.deb
rm *.deb
rm libapache2-mod-tile*.*
