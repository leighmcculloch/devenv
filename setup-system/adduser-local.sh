username="$1"
sudo -H -u "$username" sh -c 'wget -qO - https://github.com/leighmcculloch/scripts-ubuntu/raw/master/setup-user.sh | sh'
