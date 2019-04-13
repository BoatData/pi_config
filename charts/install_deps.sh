
base=/home/boatdata

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 {pbf_url}"; exit 1;
fi

source ${base}/pi_config/charts/config.sh ${1}

cat <<EOF

The values for the installation are
User          : ${OSM_USER}
Database name : ${OSM_DB}
Server name   : ${VHOST}
Backend       : mod_tile
PBF URL       : ${PBF_URL}
To change these values, edit the script file

If the values are not correct, break this script (CTRL-C) now or wait 10s to continue

Some package will ask you some question, answer with the default values which
have been modified to represent your values.

EOF
sleep 10s

if [ -f /etc/apache2/sites-available/tileserver_site.conf ]; then
  echo "tileserver already installed exiting..."
  exit
fi

#-------------------------------------------------------------------------------
#--- 1. Install package
#-------------------------------------------------------------------------------
echo ""
echo "1. Install needed packages"
echo "=========================="
#export DEBIAN_FRONTEND=noninteractive
apt install -y -q ttf-unifont \
    fonts-arphic-ukai \
    fonts-arphic-uming \
    fonts-thai-tlwg \
    postgresql \
    postgresql-contrib \
    postgresql-server-dev-all \
    postgis \
    osm2pgsql \
    osmosis \
    apache2 \
    libapache2-mod-wsgi \
    javascript-common \
    libjs-leaflet
#--- prepare the answer for database and automatic download of shape files
echo "openstreetmap-carto openstreetmap-carto/database-name string ${OSM_DB}" | debconf-set-selections
echo "openstreetmap-carto-common openstreetmap-carto/fetch-data boolean true" | debconf-set-selections
apt install -y openstreetmap-carto
apt install -y git build-essential \
     fakeroot \
     devscripts \
     apache2-dev \
     libmapnik-dev
apt clean

# To avoid the label cut between tiles, add the avoid-edges in the default style
sed -i 's/<Map/<Map\ buffer-size=\"512\"\ /g' /usr/share/openstreetmap-carto/style.xml
# This line is not needed for the moment
#sed -i 's/<ShieldSymbolizer/<ShieldSymbolizer\ avoid-edges=\"true\"\ /g' /usr/share/openstreetmap-carto/style.xml

#-------------------------------------------------------------------------------
#--- 2. Create system user
#-------------------------------------------------------------------------------
echo ""
echo "2. Create the user"
echo "===================="
if [ $(grep -c ${OSM_USER} /etc/passwd) -eq 0 ]; then	#if we don't have the OSM user
    # Password is disabled by default, so no access is possible
    useradd -m ${OSM_USER} -s /bin/bash -c "OpenStreetMap"
fi
