# apt-get source for cf-cli
echo "deb http://packages.cloudfoundry.org/debian stable main" | tee /etc/apt/sources.list.d/cloudfoundry-cli.list
curl -s https://packages.cloudfoundry.org/debian/cli.cloudfoundry.org.key | apt-key add -

# Update local package directory
apt-get -y update

# Install Cloud Foundry CLI
apt-get -y install \
  cf-cli \
