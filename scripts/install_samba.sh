
sudo apt-get install -y samba samba-common-bin
sudo chmod 1777 /home/boatdata

sudo cat >> /etc/samba/smb.conf <<sambaconf
[share]
Comment = Pi shared folder
Path = /home/boatdata
Browseable = yes
Writeable = Yes
only guest = no
create mask = 0777
directory mask = 0777
Public = yes
Guest ok = no
sambaconf

# change the samba password for the pi user below
# from raspberry to something else
# e.g. sudo smbpasswd -a pi myverylongsecretpassword
sudo smbpasswd -a pi raspberry
sudo /etc/init.d/samba restart
