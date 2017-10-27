gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
\curl -sSL https://get.rvm.io | bash -s stable --ruby
echo >> /etc/adduser.conf
echo EXTRA_GROUPS=rvm >> /etc/adduser.conf
echo ADD_EXTRA_GROUPS=1 >> /etc/adduser.conf
