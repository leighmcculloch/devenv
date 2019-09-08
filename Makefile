ID ?= 0
TZ ?= $(shell readlink /etc/localtime | sed -E 's/.*\/([A-Za-z_]+\/[A-Za-z_]+)/\1/g')
HOST ?= $(shell hostname | tr '[:upper:]' '[:lower:]' | sed 's/\.local$$//')

start:
	docker network create devenv || true
	docker run -d -i -t \
		--network="devenv" \
		--hostname="devenv-$(ID)" \
		-e TZ=$(TZ) \
		-e DISPLAY=docker.for.mac.localhost:0 \
		-e HOST="$(HOST)" \
		-v="$$HOME/.ssh/id_rsa:/home/leighmcculloch/.ssh/id_rsa" \
		-v="$$PWD:/home/leighmcculloch/devel/.devenv" \
		-v="/var/run/docker.sock:/var/run/docker.sock" \
		--security-opt="apparmor=unconfined" \
		--cap-add=SYS_PTRACE \
		-p="8$(ID)00:8000" \
		-p="8$(ID)01:8001" \
		-p="8$(ID)02:8002" \
		-p="8$(ID)03:8003" \
		-p="8$(ID)04:8004" \
		-p="8$(ID)05:8005" \
		-p="8$(ID)06:8006" \
		-p="8$(ID)07:8007" \
		-p="8$(ID)08:8008" \
		--name="devenv-$(ID)" \
		leighmcculloch/devenv:latest \
		|| docker start "devenv-$(ID)"
	docker ps

join:
	docker ps
	docker attach --detach-keys="ctrl-a,d" "devenv-$(ID)" || true
	docker ps

stop:
	docker stop $$(docker ps -aq --filter 'name=devenv-$(ID)') || true

rm:
	docker rm $$(docker ps -aq --filter 'name=devenv-$(ID)') || true

build:
	docker build --build-arg USER=$(USER) -t leighmcculloch/devenv:latest .

buildnc:
	docker build --build-arg USER=$(USER) --no-cache -t leighmcculloch/devenv:latest .

pull:
	docker pull leighmcculloch/devenv:latest
