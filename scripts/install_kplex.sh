

base=/home/boatdata
mkdir -p ${base}/tmp
cd ${base}/tmp

# install kplex
sudo apt remove -y kplex
if [ ! -f "kplex_1.3.4-1_armhf.deb" ]; then
  echo 'getting kplex in ' `pwd`
  wget http://www.stripydog.com/download/kplex_1.3.4-1_armhf.deb
fi
echo 'installing kplex'
sudo apt install -y ${base}/tmp/kplex_1.3.4-1_armhf.deb
mkdir -p ${base}/pi_config/config
sudo mv /etc/kplex.conf ${base}/pi_config/config/
sudo ln -s ${base}/pi_config/config/kplex.conf /etc/kplex.conf
