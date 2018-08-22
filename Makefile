ID ?= 0

default:
	$(call run,)

rust dart:
	$(call run,$@)

stop:
	docker stop $$(docker ps -aq)

clean:
	docker rm $$(docker ps -aq)

build:
	docker build -f Dockerfile . -t leighmcculloch/devenv:latest

build-extra:
	docker build -f Dockerfile-rust . -t leighmcculloch/devenv:latestrust
	docker build -f Dockerfile-dart . -t leighmcculloch/devenv:latestdart

pull:
	docker pull leighmcculloch/devenv

define run
	docker network create devenv || true
	docker run -d -i -t \
		--name="devenv-$(1)-$(ID)" \
		--network="devenv" \
		-v="$$HOME/.ssh/id_rsa:/root/.ssh/id_rsa" \
		-v="$$PWD:/root/devel/devenv" \
		leighmcculloch/devenv:latest$(1) \
		|| docker start devenv-$(1)-$(ID)
	docker ps
	docker attach --detach-keys="ctrl-a,d" devenv-$(1)-$(ID) || true
	docker ps
endef
