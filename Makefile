ID ?= 0

run:
	docker network create devenv || true
	docker run -d -i -t \
		--network="devenv" \
		-e DISPLAY=docker.for.mac.localhost:0 \
		-v="$$HOME/.ssh/id_rsa:/root/.ssh/id_rsa" \
		-v="$$PWD:/root/devel/devenv" \
		-v="/var/run/docker.sock:/var/run/docker.sock" \
		--name="devenv-$(ID)" \
		leighmcculloch/devenv:latest \
		|| docker start "devenv-$(ID)"
	docker ps
	docker attach --detach-keys="ctrl-a,d" "devenv-$(ID)" || true
	docker ps

stop:
	docker stop $$(docker ps -aq)

clean:
	docker rm $$(docker ps -aq)

build:
	docker build -t leighmcculloch/devenv:latest .

pull:
	docker pull leighmcculloch/devenv:latest
