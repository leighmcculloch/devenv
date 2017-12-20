ID ?= 0

basic:
	$(call run,)

go ruby rust: 
	$(call run,$@)

stop:
	docker stop $$(docker ps -aq)

clean:
	docker rm $$(docker ps -aq)

build:
	docker build -f Dockerfile . -t leighmcculloch/devenv:latest
	docker build -f Dockerfile-go . -t leighmcculloch/devenv:latestgo
	docker build -f Dockerfile-ruby . -t leighmcculloch/devenv:latestruby
	docker build -f Dockerfile-rust . -t leighmcculloch/devenv:latestrust

pull:
	docker pull leighmcculloch/devenv

define run
	docker run -d -i -t --name="devenv-$(1)-$(ID)" \
		-v="$$HOME/.ssh/id_rsa:/root/.ssh/id_rsa" \
		-v="$$PWD:/root/devenv" \
		-p="808$(ID):808$(ID)" \
		-p="606$(ID):606$(ID)" \
		leighmcculloch/devenv:latest$(1) \
		|| docker start devenv-$(1)-$(ID)
	docker ps
	docker attach --detach-keys="ctrl-a,d" devenv-$(1)-$(ID) || true
	docker ps
endef
