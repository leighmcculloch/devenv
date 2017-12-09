run:
	docker run -d -i -t --name="devenv" \
		-v="$$HOME/.ssh/id_rsa:/root/.ssh/id_rsa" \
		-v="$$PWD:/root/devenv" \
		-p="4567:4567" \
		-p="8080:8080" \
		-p="6060:6060" \
		leighmcculloch/devenv \
		|| docker start devenv
	docker ps
	docker attach --detach-keys="ctrl-a,d" devenv || true
	docker ps

clean:
	docker stop devenv || true
	docker rm devenv || true

build:
	docker build . -t leighmcculloch/devenv

pull:
	docker pull leighmcculloch/devenv
