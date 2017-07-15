# Install Neovim
add-apt-repository -y ppa:neovim-ppa/stable
apt-get update
apt-get install -y neovim

# Install python3 for Neovim python modules
apt-get install -y python-dev python-pip python3-dev python3-pip
pip3 install --upgrade neovim
