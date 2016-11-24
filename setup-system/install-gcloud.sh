# apt-get source for google-cloud-sdk
echo "deb http://packages.cloud.google.com/apt cloud-sdk-$(lsb_release -c -s) main" | tee /etc/apt/sources.list.d/google-cloud-sdk.list
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -

# Update local package directory
apt-get -y update

# Install Google Cloud SDK
apt-get -y install \
  google-cloud-sdk \
