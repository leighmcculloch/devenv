mkdir -p /usr/local/swift/
cd /usr/local/swift
curl https://swift.org/builds/swift-2.2.1-release/ubuntu1510/swift-2.2.1-RELEASE/swift-2.2.1-RELEASE-ubuntu15.10.tar.gz | tar xz
ln -s /usr/local/swift/swift-2.2.1-RELEASE-ubuntu15.10/usr/bin/swift /usr/local/bin/swift2
ln -s /usr/local/swift/swift-2.2.1-RELEASE-ubuntu15.10/usr/bin/swiftc /usr/local/bin/swiftc2
curl https://swift.org/builds/swift-3.0-preview-1/ubuntu1510/swift-3.0-PREVIEW-1/swift-3.0-PREVIEW-1-ubuntu15.10.tar.gz | tar xz
ln -s /usr/local/swift/swift-3.0-PREVIEW-1-ubuntu15.10/usr/bin/swift /usr/local/bin/swift3
ln -s /usr/local/swift/swift-3.0-PREVIEW-1-ubuntu15.10/usr/bin/swiftc /usr/local/bin/swiftc3
ln -s /usr/local/bin/swift3 /usr/local/bin/swift
ln -s /usr/local/bin/swiftc3 /usr/local/bin/swiftc
cd -
