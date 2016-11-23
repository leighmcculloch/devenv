apt-get -y install \
  clang \
  libicu-dev \
  libpython2.7-dev \
  libxml2

mkdir -p /usr/local/swift/
cd /usr/local/swift
curl https://swift.org/builds/swift-3.0.1-release/ubuntu1604/swift-3.0.1-RELEASE/swift-3.0.1-RELEASE-ubuntu16.04.tar.gz | tar xz
ln -s /usr/local/swift/swift-3.0.1-RELEASE-ubuntu16.04/usr/bin/swift /usr/local/bin/swift3
ln -s /usr/local/swift/swift-3.0.1-RELEASE-ubuntu16.04/usr/bin/swiftc /usr/local/bin/swiftc3
ln -s /usr/local/bin/swift3 /usr/local/bin/swift
ln -s /usr/local/bin/swiftc3 /usr/local/bin/swiftc
cd -
