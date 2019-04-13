
# download the pbf file if it doesn't exist
base=/home/boatdata

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 {pbf_url}"; exit 1;
fi

source ${base}/pi_config/charts/config.sh ${1}

mkdir -p ${base}/osm

pushd ${base}/osm

if [ ! -f ${PBF_FILE} ]; then

  #-------------------------------------------------------------------------------
  #--- 4. Download file and inject in database
  #-------------------------------------------------------------------------------
  echo ""
  echo "3 and a bit, download pbf file"
  echo "======================"
  # Download the latest state file first
  wget -O state.txt ${UPDATE_URL}/state.txt
  # Download main data file
  wget ${PBF_URL}
else
  echo ${PBF_FILE} already downloaded
fi

popd
