wget -qO - https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-177.0.0-linux-x86_64.tar.gz | tar xz -C /usr/local

/usr/local/google-cloud-sdk/install.sh \
	--usage-reporting false \
	--additional-components app-engine-go cloud-datastore-emulator pubsub-emulator \
	--rc-path ~/.zshrc \
	--command-completion true \
	--path-update true \
	--quiet
