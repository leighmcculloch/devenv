apt-get install git

DEVENV_DIR=.devenv

git clone https://github.com/leighmcculloch/devenv $DEVENV_DIR

cd $DEVENV_DIR/setup-system
./setup.sh
cd -
