
# crystal is a ruby like language that compiles to an executable

base=/home/boatdata
mkdir -p ${base}/tmp
cd ${base}/tmp

echo "deb http://public.portalier.com raspbian/" > /etc/apt/sources.list.d/crystal.list
curl "http://public.portalier.com/raspbian/julien%40portalier.com-005faf9e.pub" | sudo apt-key add -

sudo apt-get update
sudo apt-get install crystal
