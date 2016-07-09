username="$1"
cd /home/"$username"
sudo -H -u "$username" sh -c '/usr/local/sbin/adduser/setup.sh'
