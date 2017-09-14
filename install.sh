pkgs="python
realvnc"

base=/home/boatdata/pi_config
cd ${base}

# install samba file sharing
sudo apt-get update
sudo apt-get upgrade

# before installing samba file sharing change the samba password
# for the pi samba user in the install script
# bash scripts/install_samba.sh

# remove a whole load of stuff we ain't gonna need
bash scripts/strip_pi.sh

# install essential things
bash scripts/install_essential.sh

# use raspi_config to enable stuff e.g. ssh

# install kplex multiplexer
bash scripts/install_kplex.sh

# install opencpn
bash scripts/install_opencpn.sh

# install charts for OpenCPN

# install zyGrib
bash scripts/install_zygrib.sh

# install world maps
# http://www.zygrib.org/#section_maps

# install signalk-server-node
bash pi_config/scripts/install_signalk.sh

# install vnc
bash pi_config/install_vnc.sh

# install free charts
